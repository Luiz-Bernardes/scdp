module Pauses
  class FinishPauseService
    def initialize(pause:)
      @pause = pause
    end

    def call
      ActiveRecord::Base.transaction do
        @pause.update!(
          ended_at: Time.current,
          status: :finished
        )

        process_queue
      end

      @pause
    end

    private

    def process_queue
      next_in_queue = PauseQueue
        .where(
          pause_type: @pause.pause_type,
          status: "waiting"
        )
        .order(:position)
        .first

      return unless next_in_queue

      Pauses::StartPauseService.new(
        user: next_in_queue.user,
        pause_type: next_in_queue.pause_type,
        selected_duration_minutes: next_in_queue.selected_duration_minutes
      ).call

      next_in_queue.update!(status: "processed")
    end
  end
end