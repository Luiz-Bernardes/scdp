module Pauses
  class QueuePauseService
    def initialize(user:, pause_type:, selected_duration_minutes: nil)
      @user = user
      @pause_type = pause_type
      @selected_duration_minutes = selected_duration_minutes
    end

    def call
      last_position = PauseQueue
        .where(pause_type: @pause_type)
        .maximum(:position) || 0

      PauseQueue.create!(
        user: @user,
        team: @pause_type.team,
        pause_type: @pause_type,
        selected_duration_minutes: @selected_duration_minutes,
        position: last_position + 1,
        status: "waiting",
        requested_at: Time.current
      )
    end
  end
end