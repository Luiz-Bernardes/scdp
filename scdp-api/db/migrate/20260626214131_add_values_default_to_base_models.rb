class AddValuesDefaultToBaseModels < ActiveRecord::Migration[7.2]
  def change
    change_column :users, :role, :integer, default: 3
    change_column :teams, :active, :boolean, default: true, null: false
    change_column :team_memberships, :pending, :boolean, default: true, null: false
    change_column :pause_types, :active, :boolean, default: true, null: false
    change_column :pause_types, :has_time_limit, :boolean, default: false, null: false
    change_column :pause_types, :requires_queue, :boolean, default: false, null: false
    change_column :pauses, :status, :integer, default: 0, null: false
  end
end
