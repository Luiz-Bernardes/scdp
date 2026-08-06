module Admin
  class TeamMembershipsController < ApplicationController
    before_action :authorize_manage_teams!

    def index
      team_memberships = TeamMembership
        .includes(
          :user,
          :team
        )
        .order(:id)

      render json: team_memberships.map { |team_membership|

        Admin::TeamMembershipPresenter.new(
          team_membership: team_membership
        ).call

      }
    end

    def show
      render json:
        Admin::TeamMembershipPresenter.new(
          team_membership: team_membership
        ).call
    end

    def create
      team_membership = TeamMembership.create!(
        team_membership_params
      )

      render json:
        Admin::TeamMembershipPresenter.new(
          team_membership: team_membership
        ).call,
        status: :created
    end

    def update
      team_membership.update!(
        team_membership_params
      )

      render json:
        Admin::TeamMembershipPresenter.new(
          team_membership: team_membership
        ).call
    end

    def destroy
      team_membership.destroy!

      head :no_content
    end

    private

    def team_membership
      @team_membership ||= TeamMembership
        .includes(
          :user,
          :team
        )
        .find(params[:id])
    end

    def team_membership_params
      params
        .require(:team_membership)
        .permit(
          :email,
          :team_id,
          :team_role
        )
    end
  end
end