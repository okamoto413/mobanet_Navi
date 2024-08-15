class CreateUserInputs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_inputs do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :data_usage, null: false, default: 0, precision: 10, scale: 2
      t.integer :call_time, null: false, default: 0
      t.integer :sms_usage, null: false, default: 0

      t.timestamps
    end
  end
end
