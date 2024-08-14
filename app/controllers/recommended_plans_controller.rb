class RecommendedPlansController < ApplicationController
  before_action :set_recommended_plan, only: %i[ show edit update destroy ]

  # GET /recommended_plans or /recommended_plans.json
  def index
    @recommended_plans = RecommendedPlan.all
  end

  # GET /recommended_plans/1 or /recommended_plans/1.json
  def show
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

    respond_to do |format|
      if @recommended_plan.save
        format.html { redirect_to recommended_plan_url(@recommended_plan), notice: "Recommended plan was successfully created." }
        format.json { render :show, status: :created, location: @recommended_plan }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recommended_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recommended_plans/1 or /recommended_plans/1.json
  def update
    respond_to do |format|
      if @recommended_plan.update(recommended_plan_params)
        format.html { redirect_to recommended_plan_url(@recommended_plan), notice: "Recommended plan was successfully updated." }
        format.json { render :show, status: :ok, location: @recommended_plan }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recommended_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recommended_plans/1 or /recommended_plans/1.json
  def destroy
    @recommended_plan.destroy

    respond_to do |format|
      format.html { redirect_to recommended_plans_url, notice: "Recommended plan was successfully destroyed." }
      format.json { head :no_content }
    end
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
