module Broadcasts
  class TeamPauseStateService
    def initialize(team:, pause_type:)
      @team = team
      @pause_type = pause_type
    end

    def call
      ActionCable.server.broadcast(
        "team_#{team.id}",
        {
          type: 'pause_state_updated',
          pause_type_id: pause_type.id,
          pause_type_name: pause_type.name,
          slots: slots_payload
        }
      )
    end

    private

    attr_reader :team, :pause_type

    def slots_payload
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
          user_id: pause.user.id,
          user_name: pause.user.name,
          selected_duration_minutes: pause.selected_duration_minutes,
          started_at: pause.started_at
        }
      end

      remaining_slots = pause_type.max_concurrent - slots.size

      slots + Array.new(remaining_slots, nil)
    end
  end
end