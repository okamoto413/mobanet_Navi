class RecommendedPlansController < ApplicationController
  before_action :set_recommended_plan, only: %i[ show edit update destroy ]

  # GET /recommended_plans or /recommended_plans.json
  def index
    # CSVファイルからPlanデータを読み込む
    @plans = Plan.all

    # @recommended_plansをもとに該当するCSVプランを探すo
    @recommended_plans = RecommendedPlan.where(user_id: current_user.id).order(created_at: :desc)
    

    @recommended_plan_details = @recommended_plans.map do |recommended_plan|
      @plans.find { |plan| plan.id == recommended_plan.plan_id }
    end
  end

  # GET /recommended_plans/1 or /recommended_plans/1.json
  def show
     @recommended_plans = RecommendedPlan.where(user_id: params[:user_input_id])
  end

  # GET /recommended_plans/new
  def new
    @recommended_plan = RecommendedPlan.new
  end

  # GET /recommended_plans/1/edit
  def edit
  end

  # POST /recommended_plans or /recommended_plans.json
  def create
    @recommended_plan = RecommendedPlan.new(recommended_plan_params)

    if @recommended_plan.save
      redirect_to @recommended_plan, notice: "Recommended plan was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
      

  # PATCH/PUT /recommended_plans/1 or /recommended_plans/1.json
  def update
    if @recommended_plan.update(recommended_plan_params)
      redirect_to @recommended_plan, notice: "Recommended plan was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end


  # DELETE /recommended_plans/1 or /recommended_plans/1.json
  def destroy
    @recommended_plan.destroy
    redirect_to recommended_plans_url, notice: "Recommended plan was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommended_plan
      @recommended_plan = RecommendedPlan.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def recommended_plan_params
      params.require(:recommended_plan).permit(:user_id, :plan_id, :reason)
    end
end
