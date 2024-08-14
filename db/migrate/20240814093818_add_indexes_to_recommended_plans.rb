class AddIndexesToRecommendedPlans < ActiveRecord::Migration[6.1]
  def change
    add_index :recommended_plans, :user_id
    add_index :recommended_plans, :plan_id
  end
end
