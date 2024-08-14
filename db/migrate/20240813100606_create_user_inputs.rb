class CreateUserInputs < ActiveRecord::Migration[6.1]
  def change
    create_table :user_inputs do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :data_usage
      t.integer :call_time
      t.integer :sms_usage

      t.timestamps
    end
  end
end
