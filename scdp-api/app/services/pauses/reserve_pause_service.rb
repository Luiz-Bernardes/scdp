module Pauses
  class ReservePauseService
    def initialize(user:, pause_type:, selected_duration_minutes: nil)
      @user = user
      @pause_type = pause_type
      @team = pause_type.team
      @selected_duration_minutes = selected_duration_minutes&.to_i
    end

    def call
      validate_active_pause!
      validate_duration!

      if pause_limit_reached?
        return enqueue if @pause_type.requires_queue?

        raise StandardError, "Pause limit reached"
      end

      create_reserved_pause
    end

    private

    attr_reader :selected_duration_minutes

    def validate_active_pause!
      return unless @user.pauses.occupying_slot.exists?

      raise StandardError, "User already has an active pause"
    end

    def validate_duration!
      return unless @pause_type.has_time_limit?
      return if selected_duration_minutes.present?

      raise StandardError, "Duration is required"
    end

    def pause_limit_reached?
      @pause_type.pauses.occupying_slot.count >=
        @pause_type.max_concurrent
    end

    def enqueue
      QueuePauseService.new(
        user: @user,
        pause_type: @pause_type,
        selected_duration_minutes: selected_duration_minutes
      ).call
    end

    def create_reserved_pause
      pause = Pause.create!(
        user: @user,
        team: @team,
        pause_type: @pause_type,
        selected_duration_minutes: selected_duration_minutes,
        status: :reserved,
        started_at: nil,
        expires_at: nil
      )

      ExpirePauseJob.set(
        wait: PauseSettings::RESERVE_EXPIRE_TIMEOUT
      ).perform_later(
        pause.id,
        "reserved"
      )

      Broadcasts::TeamPauseStateService.new(
        team: pause.team,
        pause_type: pause.pause_type
      ).call

      pause
    end
  end
end