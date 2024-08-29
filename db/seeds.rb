require 'csv'
Plan.load_from_csv
# CSV ファイルのパスを指定
plans_csv_path = Rails.root.join('db', 'seeds', 'plans.csv')
# call_fees_csv_path = Rails.root.join('db', 'seeds', 'call_fees.csv')

# CSV ファイルを読み込み、Plan モデルにデータを保存
begin
CSV.foreach(plans_csv_path, headers: true) do |row|
    # next if row['carrier'].nil?
    next if row['carrier'].blank? || row['plan_name'].blank? || row['data_capacity'].blank? || row['monthly_fee'].blank? || row['plan_type'].blank?
  
    # データの変換
    data_capacity = row['data_capacity']
    data_capacity = data_capacity.to_f if data_capacity.present?
    monthly_fee = row['monthly_fee'].to_f

    plan = Plan.create!(
    carrier: row['carrier'].to_i,
    plan_name: row['plan_name'],
    data_capacity: row['data_capacity']
    # data_capacity = data_capacity.to_f if data_capacity.present?,
    monthly_fee: row['monthly_fee'].to_f,
    plan_type: row['plan_type'].to_i,
    official_url: row['official_url']
  )

  # CallFee を追加する場合、必要に応じて call_fees.csv から読み込み
  # call_fees.csv に対応するプランの通話料金情報が含まれていると仮定
end

rescue ActiveRecord::RecordInvalid => e
  puts "Failed to create plan: #{e.message}"
rescue StandardError => e
  puts "An error occurred: #{e.message}"
end

# 通話料金の CSV を読み込み、CallFee モデルにデータを保存
# CSV.foreach(call_fees_csv_path, headers: true) do |row|
#   CallFee.create!(
#     plan_id: row['plan_id'],
#     call_duration: row['call_duration'],
#     call_fee: row['call_fee']
#   )
# end