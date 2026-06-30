module Pauses
  class StartPauseService
    def initialize(user:, pause_type:, selected_duration_minutes: nil)
      @user = user
      @pause_type = pause_type
      @team = pause_type.team
      @selected_duration_minutes = selected_duration_minutes
    end

    def call
      validate_active_pause!
      validate_duration!

      if pause_limit_reached?
        return enqueue if @pause_type.requires_queue?
        raise StandardError, "Pause limit reached"
      end

      create_pause
    end

    private

    def validate_active_pause!
      return unless @user.pauses.active.exists?

      raise StandardError, "User already has an active pause"
    end

    def validate_duration!
      return unless @pause_type.has_time_limit?
      return if @selected_duration_minutes.present?

      raise StandardError, "Duration is required"
    end

    def pause_limit_reached?
      @pause_type.pauses.active.count >= @pause_type.max_concurrent
    end

    def enqueue
      QueuePauseService.new(
        user: @user,
        pause_type: @pause_type,
        selected_duration_minutes: @selected_duration_minutes
      ).call
    end

    def create_pause
      pause = Pause.create!(
        user: @user,
        team: @team,
        pause_type: @pause_type,
        selected_duration_minutes: @selected_duration_minutes,
        started_at: Time.current,
        status: :active
      )

      Broadcasts::TeamPauseStateService.new(
        team: pause.team,
        pause_type: pause.pause_type
      ).call

      pause
    end
  end
end