class ModifyPlansTable < ActiveRecord::Migration[6.1]
  def change
    change_table :plans do |t|
      t.change :name, :string, null: false, limit: 255
      t.change :carrier, :bigint, null: false
      t.change :monthly_fee, :decimal, null: false, default: 0
      t.change :data_capacity, :string, limit: 50, null: false
      t.change :call_fee, :decimal, null: false, default: 0
      t.change :plan_type, :bigint, null: false
  end
end
