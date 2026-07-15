module Admin
  class TeamPresenter
    def initialize(team:)
      @team = team
    end

    def call
      {
        id: team.id,
        name: team.name,
        active: team.active,
        created_at: team.created_at,
        updated_at: team.updated_at
      }
    end

    private

    attr_reader :team
  end
end