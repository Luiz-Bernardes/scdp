module Admin
  class UserPresenter
    def initialize(user:)
      @user = user
    end

    def call
      {
        id: user.id,
        name: user.name,
        email: user.email,
        role: user.role,
        active: user.active,
        team_ids: user.teams.pluck(:id),
        team_names: user.teams.pluck(:name),
        created_at: user.created_at,
        updated_at: user.updated_at
      }
    end

    private

    attr_reader :user
  end
end