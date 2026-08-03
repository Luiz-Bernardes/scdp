module Admin
  class TeamMembershipPresenter

    def initialize(team_membership:)
      @team_membership = team_membership
    end

    def call
      {
        id: team_membership.id,

        user_id: team_membership.user_id,
        user_name: team_membership.user.name,

        team_id: team_membership.team_id,
        team_name: team_membership.team.name,

        created_at: team_membership.created_at,
        updated_at: team_membership.updated_at
      }
    end

    private

    attr_reader :team_membership

  end
end