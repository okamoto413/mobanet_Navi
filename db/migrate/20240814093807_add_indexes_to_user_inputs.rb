class AddIndexesToUserInputs < ActiveRecord::Migration[6.1]
  def change
    add_index :user_inputs, :user_id
  end
end
