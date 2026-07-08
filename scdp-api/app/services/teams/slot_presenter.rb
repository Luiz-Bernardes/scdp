module Teams
  class SlotPresenter
    def initialize(pause:)
      @pause = pause
    end

    def call
      timer = Pauses::TimerService.new(
        pause: pause
      )

      {
        pause_id: pause.id,

        status: timer.status,

        user_name: pause.user.name,

        selected_duration_minutes:
          pause.selected_duration_minutes,

        started_at: pause.started_at,

        expires_at: pause.expires_at,

        remaining_seconds:
          timer.remaining_seconds,

        overtime_seconds:
          timer.overtime_seconds,

        progress_percentage:
          timer.progress_percentage,

        expired:
          timer.expired?,

        can_start: can_start?,

        can_finish: can_finish?
      }
    end

    private

    attr_reader :pause

    def can_start?
      pause.reserved?
    end

    def can_finish?
      pause.active? || pause.waiting_return?
    end
  end
end