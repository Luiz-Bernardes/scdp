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

        Broadcasts::TeamPauseStateService.new(
          team: @pause.team,
          pause_type: @pause.pause_type
        ).call

        reserve_next_in_queue
      end

      @pause
    end

    private

    def reserve_next_in_queue
      next_in_queue = PauseQueue
        .where(
          pause_type: @pause.pause_type,
          status: "waiting"
        )
        .order(:position)
        .first

      return unless next_in_queue

      pause = Pauses::ReservePauseService.new(
        user: next_in_queue.user,
        pause_type: next_in_queue.pause_type,
        selected_duration_minutes: next_in_queue.selected_duration_minutes
      ).call

      next_in_queue.update!(
        status: "processed",
        requested_at: Time.current
      )

      pause
    end
  end
end