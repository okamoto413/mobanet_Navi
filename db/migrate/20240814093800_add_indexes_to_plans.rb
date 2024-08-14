class AddIndexesToPlans < ActiveRecord::Migration[6.1]
  def change
    add_index :plans, :name
    add_index :plans, :carrier
    add_index :plans, :plan_type
end
