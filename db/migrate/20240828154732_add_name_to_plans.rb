class AddNameToPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :plans, :name, :string
  end
end
