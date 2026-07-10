module Teams
  class PauseBoardService
    def initialize(team:)
      @team = team
    end

    def call
      {
        team_id: team.id,
        pause_types: team.pause_types.active.map do |pause_type|
          {
            id: pause_type.id,
            name: pause_type.name,

            has_time_limit: pause_type.has_time_limit,
            max_duration_minutes: pause_type.max_duration_minutes,
            max_concurrent: pause_type.max_concurrent,
            requires_queue: pause_type.requires_queue,

            slots: build_slots(pause_type)
          }
        end
      }
    end

    private

    attr_reader :team

    def build_slots(pause_type)
      occupying_pauses = Pause.occupying_slot
                              .includes(:user)
                              .where(
                                team: team,
                                pause_type: pause_type
                              )
                              .order(:started_at)

      slots = occupying_pauses.map do |pause|
        Teams::SlotPresenter.new(
          pause: pause
        ).call
      end

      remaining_slots = pause_type.max_concurrent - slots.size

      slots + Array.new(remaining_slots, nil)
    end
  end
end