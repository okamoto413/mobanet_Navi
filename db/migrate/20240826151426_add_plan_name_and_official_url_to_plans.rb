class AddPlanNameAndOfficialUrlToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :plan_name, :string
    add_column :plans, :official_url, :string
  end
end
