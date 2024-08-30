class AddDetailsToUserInputs < ActiveRecord::Migration[6.1]
  def change
    add_column :user_inputs, :monthly_fee, :decimal, default: 0, null: false
    add_column :user_inputs, :other_monthly_fee, :decimal
    add_column :user_inputs, :carrier, :bigint
    add_column :user_inputs, :plan_name, :string
    add_column :user_inputs, :priority, :string
  end
end
