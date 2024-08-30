class UserInputsController < ApplicationController
  before_action :set_user_input, only: %i[ show edit update destroy ]

  # GET /user_inputs or /user_inputs.json
  def index
    @user_inputs = UserInput.all
  end

  # GET /user_inputs/1 or /user_inputs/1.json
  def show
  end

  # GET /user_inputs/new
  def new
    @user_input = UserInput.new
  end

  # GET /user_inputs/1/edit
  def edit
  end

  # POST /user_inputs or /user_inputs.json
  def create
    @user_input = current_user.user_inputs.new(user_input_params)

    if @user_input.save
      # 推奨プランを取得して保存する処理をメソッドに分割
      recommend_plans(@user_input)
      redirect_to recommended_plans_path(user_input_id: @user_input.id), notice: "診断結果はこちらです。"
    else
      render :new, status: :unprocessable_entity
    end
  end
      # 推奨プランを取得して保存する
    #   Plan.save_recommended_plans(@user_input)
    #   redirect_to recommended_plans_path(user_input_id:@user_input.id), notice: "診断結果はこちらです。"
    # else
    #   render :new, status: :unprocessable_entity
    # end

    # @user_input = current_user.user_inputs.build(user_input_params)

    # if @user_input.save
    #   redirect_to plans_path(user_input_id: @user_input.id), notice: "診断結果はこちらです。"
    # else
    #   render :new, status: :unprocessable_entity
    # end

  # PATCH/PUT /user_inputs/1 or /user_inputs/1.json
  def update
    if @user_input.update(user_input_params)
      redirect_to @user_input, notice: "ユーザー入力が正常に更新されました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /user_inputs/1 or /user_inputs/1.json
  def destroy
    @user_input.destroy
    redirect_to user_inputs_url, notice: "ユーザー入力は正常に破棄されました."
    # respond_to do |format|
    #   format.html { redirect_to user_inputs_url, notice: "User input was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_input
      @user_input = UserInput.find(params[:id])
      # params.require(:user_input).permit(:data_usage, :call_time, :sms_usage, :monthly_fee, :other_monthly_fee, :carrier, :plan_type, :priority)
    end

    # Only allow a list of trusted parameters through.
    def user_input_params
      # params.require(:user_input).permit(:data_usage, :call_time, :current_plan_name, :priority, :sms_usage)
      params.require(:user_input).permit(:data_usage, :call_time, :sms_usage, :monthly_fee, :other_monthly_fee, :carrier, :plan_type, :priority, :plan_name)
    end

     # 推奨プランの作成ロジック
    def recommend_plans(user_input)
      filters = {
        carrier: user_input.carrier,
        plan_name: user_input.plan_name,
        data_usage: user_input.data_usage,
        priority: user_input.priority
      }

      # 条件に合致するプランを取得し、月額料金でソート
      matched_plans = Plan.search(filters).limit(5)

      # 条件に合致するプランを取得
    #   matched_plans = Plan.where(
    #   "carrier = ? AND (data_capacity::numeric >= ?)", 
    #   filters[:carrier], 
    #   filters[:data_usage]
    # ).limit(5)
    
      # 推奨プランを recommended_plans に保存
      matched_plans.each do |plan|
        RecommendedPlan.find_or_create_by(
          user_id: user_input.user_id,
          plan_id: plan.id,
          # reason: generate_recommendation_reason(plan, user_input)
        )do |rec_plan|
        rec_plan.reason = generate_recommendation_reason(plan, user_input)
        end
      end
    end
     # 推奨理由を生成するメソッド
    def generate_recommendation_reason(plan, user_input)
      "このプランはデータ使用量#{plan.data_capacity}GB、通話時間が#{plan.call_fee}で、月額料金が#{plan.monthly_fee}円で最適です。"

    end
  end