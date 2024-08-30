class CreatePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :plans do |t|
      t.string :name, null: false
      t.integer :carrier, null: false, limit: 2
      t.decimal :monthly_fee, null: false, default: 0, precision: 10, scale: 2
      t.string :data_capacity, null: false, limit: 50
      t.decimal :call_fee, null: false, default: 0, precision: 10, scale: 2
      t.integer :plan_type, null: false, limit: 2

      t.timestamps
    end
    add_index :plans, :name, unique: true
    add_index :plans, :plan_type
  end
end
