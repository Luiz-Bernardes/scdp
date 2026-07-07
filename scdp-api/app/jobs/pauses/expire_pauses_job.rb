module Pauses
  class ExpirePausesJob < ApplicationJob
    queue_as :default

    def perform
      Pause.running
           .includes(:pause_type, :team)
           .find_each do |pause|

        next unless pause.pause_type.has_time_limit?
        next unless expired?(pause)

        expire!(pause)
      end
    end

    private

    def expired?(pause)
      max_duration = pause.pause_type.max_duration_minutes

      return false if max_duration.blank?

      Time.current >= (
        pause.started_at + max_duration.minutes
      )
    end

    def expire!(pause)
      Pause.transaction do
        pause.update!(
          status: :waiting_return
        )

        Broadcasts::TeamPauseStateService.new(
          team: pause.team,
          pause_type: pause.pause_type
        ).call
      end
    end
    
  end
end