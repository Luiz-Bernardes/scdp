module Admin
  class TeamsController < ApplicationController
    before_action :authorize_manage_teams!

    def index
      teams = Team
        .where(active: true)
        .order(:name)

      render json: teams.map { |team|
        Admin::TeamPresenter.new(
          team: team
        ).call
      }
    end

    def show
      render json:
        Admin::TeamPresenter.new(
          team: team
        ).call
    end

    def create
      team = Team.new(
        team_params
      )

      team.created_by =
        current_user

      team.save!

      render json:
        Admin::TeamPresenter.new(
          team: team
        ).call,
        status: :created
    end

    def update
      team.update!(
        team_params
      )

      render json:
        Admin::TeamPresenter.new(
          team: team
        ).call
    end

    def destroy
      team.update!(
        active: false
      )

      head :no_content
    end

    private

    def team
      @team ||= Team.find(
        params[:id]
      )
    end

    def team_params
      params
        .require(:team)
        .permit(
          :name
        )
    end
  end
end