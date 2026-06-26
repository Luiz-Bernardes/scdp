class AddIndexesToTeamMemberships < ActiveRecord::Migration[7.2]
  def change
    add_index :team_memberships, [:user_id, :team_id], unique: true
    add_index :team_memberships, [:email, :team_id], unique: true
  end
end
