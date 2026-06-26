class CreateTeamMemberships < ActiveRecord::Migration[7.2]
  def change
    create_table :team_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true
      t.string :email
      t.integer :team_role
      t.boolean :pending

      t.timestamps
    end
  end
end
