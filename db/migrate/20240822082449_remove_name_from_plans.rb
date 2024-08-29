class RemoveNameFromPlans < ActiveRecord::Migration[6.1]
  def change
    remove_column :plans, :name, :string
  end
end
