class ModifyUsersTable < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, limit: 255
      t.string :encrypted_password, null: false, limit: 255
      t.boolean :admin, null: false, default: false

      t.timestamps
    end

    add_index :users, :email, unique: true
  end
end
