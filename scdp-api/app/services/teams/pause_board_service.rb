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
            slots: build_slots(pause_type)
          }
        end
      }
    end

    private

    attr_reader :team

    def build_slots(pause_type)
      active_pauses = Pause.active
                           .includes(:user)
                           .where(
                             team: team,
                             pause_type: pause_type
                           )
                           .order(:started_at)

      slots = active_pauses.map do |pause|
        {
          pause_id: pause.id,
          user_name: pause.user.name,
          selected_duration_minutes: pause.selected_duration_minutes,
          started_at: pause.started_at
        }
      end

      remaining = pause_type.max_concurrent - slots.size

      slots + Array.new(remaining, nil)
    end
  end
end