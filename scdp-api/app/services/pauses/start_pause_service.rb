module Pauses
  class StartPauseService
    def initialize(pause:)
      @pause = pause
    end

    def call
      validate_reserved!

      pause.update!(
        status: :active,
        started_at: Time.current,
        expires_at: calculate_expires_at
      )

      Broadcasts::TeamPauseStateService.new(
        team: pause.team,
        pause_type: pause.pause_type
      ).call

      pause
    end

    private

    attr_reader :pause

    def validate_reserved!
      return if pause.reserved?

      raise StandardError, "Pause is not reserved"
    end

    def calculate_expires_at
      return nil unless pause.pause_type.has_time_limit? &&
                        pause.selected_duration_minutes.present?

      Time.current + pause.selected_duration_minutes.minutes
    end
  end
end