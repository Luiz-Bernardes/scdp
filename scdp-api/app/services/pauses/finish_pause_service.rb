module Pauses
  class FinishPauseService
    def initialize(pause:)
      @pause = pause
    end

    def call
      ActiveRecord::Base.transaction do
        @pause.update!(
          status: :finished,
          ended_at: Time.current
        )

        # Broadcasts::TeamPauseStateService.new(
        #   team: @pause.team,
        #   pause_type: @pause.pause_type
        # ).call

        Pauses::ReserveNextInQueueService.new(
          pause_type: @pause.pause_type
        ).call
      end

      @pause
    end

  end
end