class UserInputsTable < ActiveRecord::Migration[6.1]
  def change
    change_table :user_inputs do |t|
      t.change :data_usage, :decimal, null: false, default: 0
      t.change :call_time, :integer, null: false, default: 0
      t.change :sms_usage, :integer, null: false, default: 0
    end
  end
end
