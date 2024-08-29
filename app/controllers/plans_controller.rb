class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: %i[ show edit update destroy ]

  # GET /plans or /plans.json
  def index
    if params[:user_input_id].present?
      @user_input = UserInput.find(params[:user_input_id])
    end
      # 推奨プランのロジック: 使用量に基づいてプランをフィルタリング
      # @plans = Plan.where('data_capacity >= ?', @user_input.data_usage)
      #              .order(:monthly_fee)
      #              .limit(3)
       # user_input_idが存在しない場合のエラーハンドリング
      # unless @user_input
      #   flash[:alert] = "ユーザー入力が見つかりません。"
      #   return redirect_to plans_path
      # end

    # 修正後: 推奨プランのロジックの呼び出し
    # filters = {
    #   carrier: @user_input.carrier,
    #   plan_type: @user_input.plan_type,
    #   data_usage: @user_input.data_usage,
    #   priority: @user_input.priority
    # }
    # 推奨プランのロジックを使う
      # @plans = Plan.recommend_plans(filters)
      # 推奨プランが見つからない場合の対応
      
        # flash[:notice] = "該当するプランが見つかりませんでした。"
        @plans = Plan.all # デフォルトでプランを5件表示
  end

    # CSVファイルからプランデータをロードするメソッド  

  # GET /plans/1 or /plans/1.json
  def show
    @plan = Plan.find(params[:id])
    if params[:user_input_id].present?
    @user_input = current_user.user_inputs.find_by(id: params[:user_input_id])
    @recommended_plans = RecommendedPlan.where(user_id: @user_input.user_id) if @user_input
    end
    
    # @user_input = current_user.user_inputs.find(params[:user_input_id]) if params[:user_input_id].present?
   # 例として最新の入力データを取得
    # @recommended_plans = RecommendedPlan.where(user_id: @user_input.user_id) if @user_input.present?
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans or /plans.json
  def create
    @plan = Plan.new(plan_params)

    respond_to do |format|
      if @plan.save
        format.html { redirect_to plans_path, notice: "登録しました。" }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1 or /plans/1.json
  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to plans_path, notice: '更新しました。'
    else
      render :edit
    end
  end

    # respond_to do |format|
      # if @plan.update(plan_params)
      #   format.html { redirect_to plan_url(@plan), notice: "Plan was successfully updated." }
      #   format.json { render :show, status: :ok, location: @plan }
      # else
      #   format.html { render :edit, status: :unprocessable_entity }
      #   format.json { render json: @plan.errors, status: :unprocessable_entity }
      # end
  #   end
  # end

  # DELETE /plans/1 or /plans/1.json
  def destroy
    @plan.destroy

    respond_to do |format|
      format.html { redirect_to plans_url, notice: "Plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def plan_params
      Rails.logger.debug "Params: #{params.inspect}"
      params.require(:plan).permit(
        :carrier,
        :monthly_fee,
        :data_capacity,
        :call_fee,
        :plan_type,
        :name, # 追加
        :plan_name # 追加
      )
      # .tap do |whitelisted|
      # # carrierをシンボルに変換
      # carrier_value = params[:plan][:carrier].to_i
      # whitelisted[:carrier] = Plan.carriers.key(carrier_value)    end
    end
end
