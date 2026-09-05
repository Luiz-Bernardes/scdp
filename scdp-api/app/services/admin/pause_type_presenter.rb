module Admin
  class PauseTypePresenter
    def initialize(pause_type:)
      @pause_type = pause_type
    end

    def call
      {
        id: pause_type.id,
        name: pause_type.name,
        active: pause_type.active,
        has_time_limit: pause_type.has_time_limit,
        max_duration_minutes: pause_type.max_duration_minutes,
        max_concurrent: pause_type.max_concurrent,
        requires_queue: pause_type.requires_queue,
        team_id: pause_type.team_id,
        team_name: pause_type.team.name,
        created_at: pause_type.created_at,
        updated_at: pause_type.updated_at
      }
    end

    private

    attr_reader :pause_type
  end
end