class ExpirePauseJob < ApplicationJob
  queue_as :default

  def perform(pause_id, expected_status)
    pause = Pause.find_by(id: pause_id)

    return unless pause
    return unless pause.status == expected_status

    case expected_status
    when "reserved"
      expire_reserved_pause(pause)

    when "active"
      expire_active_pause(pause)

    when "waiting_return"
      expire_waiting_return_pause(pause)
    end
  end

  private

  def expire_reserved_pause(pause)
    pause.update!(
      status: :expired,
      ended_at: Time.current
    )

    Broadcasts::TeamPauseStateService.new(
      team: pause.team,
      pause_type: pause.pause_type
    ).call
  end

  def expire_active_pause(pause)
    pause.update!(
      status: :waiting_return
    )

    Broadcasts::TeamPauseStateService.new(
      team: pause.team,
      pause_type: pause.pause_type
    ).call

  end

  def expire_waiting_return_pause(pause)
    pause.update!(
      status: :expired,
      ended_at: Time.current
    )

    Broadcasts::TeamPauseStateService.new(
      team: pause.team,
      pause_type: pause.pause_type
    ).call
  end
end