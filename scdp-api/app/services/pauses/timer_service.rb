module Pauses
  class TimerService
    def initialize(pause:)
      @pause = pause
    end

    def remaining_seconds
      return nil unless expires_at
      return 0 if expired?

      (expires_at - Time.current).to_i
    end

    def overtime_seconds
      return nil unless expires_at
      return 0 unless expired?

      (Time.current - expires_at).to_i
    end

    def expired?
      return false unless pause.started?
      return false unless expires_at

      Time.current >= expires_at
    end

    def finished?
      pause.finished?
    end

    def status
      return "reserved" if pause.reserved?
      return "finished" if finished?
      return "waiting_return" if pause.waiting_return?
      return "expired" if expired?

      "running"
    end

    def progress_percentage
      return nil unless expires_at
      return 0 unless total_duration_seconds.positive?

      elapsed = Time.current - pause.started_at
      progress = (elapsed / total_duration_seconds) * 100

      [progress.to_i, 100].min
    end

    private

    attr_reader :pause

    def expires_at
      pause.expires_at
    end

    def total_duration_seconds
      pause.selected_duration_minutes.to_i * 60
    end
  end
end