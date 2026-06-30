class TeamChannel < ApplicationCable::Channel
  def subscribed
    team = current_user.teams.find_by(id: params[:team_id])

    return reject unless team

    stream_from "team_#{team.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end