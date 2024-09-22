class Plan < ApplicationRecord
  has_many :recommended_plans, dependent: :destroy

  validates  :carrier, :monthly_fee, :data_capacity, :call_fee, presence: true
  validates :monthly_fee, :call_fee, numericality: { greater_than_or_equal_to: 0 }
  validates :data_capacity, format: { with: /\A\d+(\.\d+)?(GB|MB)?\z/i, message: "must be a number with optional 'GB' or 'MB'" }

  enum carrier: { docomo: 0, au: 1, softbank: 2, その他: 3 }
  enum plan_type: { 音声通話SIM: 0, データ専用SIM: 1, 指定なし: 2  }

# CSVファイルからプランデータをロードするメソッド
  def self.load_from_csv(file_path= Rails.root.join('db', 'seeds', 'plans.csv'))
    return Rails.logger.error "CSV file not found at #{file_path}" unless File.exist?(file_path)
    
    plans = []
    if File.exist?(file_path)
      CSV.foreach(file_path, headers: true) do |row|
        carrier_value = map_carrier(row['carrier'])  # CSV の行からキャリア値を取得し、マッピングする
        carrier_int = Plan.carriers[carrier_value] # シンボルから整数に変換
        Rails.logger.info "Carrier value from CSV: #{carrier_int}"

        #  キャリアが無効な場合はエラーログを出力し、次の行へ進む
        if carrier_value.nil?
          Rails.logger.error "Invalid carrier value in row: #{row.inspect}"
          next
        end

      plans << Plan.new(
        carrier: carrier_value,
        plan_type: row['plan_type'].to_i,
          monthly_fee: row['monthly_fee'].to_f,
          data_capacity: row['data_capacity'],
          # call_fee が 存在しない場合は0に
          call_fee: row['call_fee'].present? ? row['call_fee'].to_f : 0,
          # call_fee: row['call_fee'].to_f || 0, 
          official_url: row['official_url']
        )
    end
    # トランザクションで一括インポート
    Plan.transaction { plans.each(&:save!) }
    # Plan.transaction do
    #   plans.each(&:save!)
    # end
  else
    Rails.logger.error "CSV file not found at #{file_path}"
  end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Failed to create plan: #{e.message}"
  rescue StandardError => e
    Rails.logger.error "An error occurred: #{e.message}"
  end

  def self.search(filters)
    plans = Plan.all
    plans = plans.where(carrier: filters[:carrier]) if filters[:carrier].present?
    plans = plans.where(plan_type: filters[:plan_type]) if filters[:plan_type].present?
     # データ容量のフィルタ
    if filters[:data_usage].present?
      data_usage_value = calculate_data_capacity(filters[:data_usage])
      plans = plans.where("data_capacity >= ?", data_usage_value)
     end 
   
    plans  
  end


  # carrier のマッピング
  def self.map_carrier(carrier_value)
    case carrier_value.to_s.strip
    when '0' then :docomo
    when '1' then :au
    when '2' then :softbank
    when '3' then :その他
    else nil
    end
  end


  # 推奨プランの作成ロジック
    def self.recommend_plans(filters)
   # フィルター条件を作成
      plans = Plan.all
      plans = plans.where(carrier: filters[:carrier]) if filters[:carrier].present?
      plans = plans.where(plan_type: filters[:plan_type]) if filters[:plan_type].present?

    if filters[:data_usage].present?
      data_usage_value = calculate_data_capacity(filters[:data_usage])
      plans = plans.where("data_capacity >= ?", data_usage_value) if data_usage_value.present?
    end

      # 優先順位に基づいてソート
    if filters[:priority] == 'cost'
      plans = plans.order(:monthly_fee)
    elsif filters[:priority] == 'data'
      plans = plans.order(data_capacity: :desc)  
    end
    plans.limit(5) # 推奨プランを5件に絞る
    Rails.logger.info "Recommended plans: #{plans.inspect}"  # 追加

  plans
  end  


  # 推奨プランを保存するロジック
  def self.save_recommended_plans(user_input)
    # 条件に合致するプランを取得
    filters = {
      carrier: user_input.carrier,
      plan_type: user_input.plan_name,
    }

   
    matched_plans = Plan.where(filters)
                      .where('data_capacity >= ?', calculate_data_capacity(user_input.data_usage))
                      .order(:monthly_fee) # 月額料金でソート 
                      #  .where('data_capacity  <= ?', calculate_data_capacity(user_input.data_usage)) # データ使用量でフィルタリング
                      # .order(user_input.priority == 'cost' ? :monthly_fee : :data_capacity)
                      .limit(5)


    Rails.logger.info "Matched plans for user #{user_input.id}: #{matched_plans.inspect}"

  # 推奨プランを recommended_plans に保存
    matched_plans.each do |plan|
      RecommendedPlan.find_or_create_by(
        user_id: user_input.user_id,
        plan_id: plan.id
      ) do |rec_plan|
        rec_plan.reason = generate_recommendation_reason(plan, user_input)
      end
    end  
  end


  # データ容量を数値に変換するメソッド
  def data_capacity_in_gb
    case data_capacity
    when /(\d+(\.\d+)?)GB/i
      $1.to_f
    when /(\d+)MB/i
      $1.to_f / 1024
    else
      data_capacity.to_f
    end
  end

# データ使用量に基づいた通話料金を計算するメソッド
  # nil の場合はデフォルトで 0 を返す
  def self.calculate_data_capacity(data_usage)
    # if data_usage.is_a?(Numeric)
    # data_usage.to_f
    # else
      case data_usage.to_s.downcase
      when 'unlimited'
        Plan.maximum(:data_capacity)   # 無制限
      when '3gb_unlimited'
        3
      when '6gb_unlimited'
        6
      when '29gb_unlimited'
        29
      else
        data_usage.to_i # 入力が数値の場合も対応
      end
    end

# 推奨理由を生成するメソッド
  def self.generate_recommendation_reason(plan, user_input)
    reason = "このプランは、月額料金#{plan.monthly_fee}円で、データ容量#{plan.data_capacity}GBのプランです。"
    reason += "通話料金も#{plan.call_fee}円とお得です。" if plan.call_fee.present?
    reason += "キャリア: #{plan.carrier}。"
    reason
  end
end
