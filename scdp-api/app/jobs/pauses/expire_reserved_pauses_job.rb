module Pauses
  class ExpireReservedPausesJob < ApplicationJob
    queue_as :default

    def perform
      Pause.reserved.find_each do |pause|
        next unless expired?(pause)

        cancel!(pause)
      end
    end

    private

    def expired?(pause)
      Time.current >= (
        pause.created_at +
        PauseSettings::RESERVATION_TIMEOUT
      )
    end

    def cancel!(pause)
      ActiveRecord::Base.transaction do
        pause.update!(
          status: :cancelled
        )

        Pauses::ReserveNextInQueueService.new(
          pause_type: pause.pause_type
        ).call

        Broadcasts::TeamPauseStateService.new(
          team: pause.team,
          pause_type: pause.pause_type
        ).call
      end
    end
  end
end