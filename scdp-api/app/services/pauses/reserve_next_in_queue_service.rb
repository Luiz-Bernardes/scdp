module Pauses
  class ReserveNextInQueueService
    def initialize(pause_type:)
      @pause_type = pause_type
    end

    def call
      next_in_queue = PauseQueue
        .where(
          pause_type: pause_type,
          status: :waiting
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
        status: :processed
      )

      pause
    end

    private

    attr_reader :pause_type
  end
end