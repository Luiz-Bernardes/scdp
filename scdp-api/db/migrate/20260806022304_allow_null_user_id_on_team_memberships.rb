class AllowNullUserIdOnTeamMemberships < ActiveRecord::Migration[7.2]
  def change
    change_column_null(
      :team_memberships,
      :user_id,
      true
    )
  end
end
