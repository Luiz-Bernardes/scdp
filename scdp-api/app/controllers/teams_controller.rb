class TeamsController < ApplicationController
  def pause_board
    team = current_user.teams.find(params[:id])

    board = Teams::PauseBoardService.new(
      team: team
    ).call

    render json: board
  end
end