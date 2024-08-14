class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name
      t.integer :carrier
      t.decimal :monthly_fee
      t.string :data_capacity
      t.decimal :call_fee
      t.integer :plan_type

      t.timestamps
    end
  end
end
