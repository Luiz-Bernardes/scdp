class ReplaceMicrosoftUidWithProviderFields < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :microsoft_uid, :string

    add_column :users, :provider, :string
    add_column :users, :provider_uid, :string

    add_index :users, [:provider, :provider_uid], unique: true
  end
end
