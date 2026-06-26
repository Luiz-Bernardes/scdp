class AddIndexesToUsers < ActiveRecord::Migration[7.2]
  def change
    add_index :users, :email, unique: true
    add_index :users, :microsoft_uid, unique: true
  end
end
