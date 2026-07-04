class MeController < ApplicationController
  def show
    render json: {
      id: current_user.id,
      name: current_user.name,
      email: current_user.email,
      role: current_user.role,
      team_ids: current_user.teams.pluck(:id)
    }
  end
end