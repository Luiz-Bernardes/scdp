module Pauses
  class QueuePauseService
    def initialize(user:, pause_type:)
      @user = user
      @pause_type = pause_type
    end

    def call
      last_position = PauseQueue
        .where(pause_type: @pause_type)
        .maximum(:position) || 0

      PauseQueue.create!(
        user: @user,
        team: @pause_type.team,
        pause_type: @pause_type,
        position: last_position + 1,
        status: "waiting",
        requested_at: Time.current
      )
    end
  end
end