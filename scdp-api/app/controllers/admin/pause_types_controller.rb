module Admin
  class PauseTypesController < ApplicationController
    before_action :authorize_manage_teams!

    def index
      pause_types = PauseType
        .includes(:team)
        .order(:id)

      render json: pause_types.map { |pause_type|
        Admin::PauseTypePresenter.new(
          pause_type: pause_type
        ).call
      }
    end

    def show
      render json:
        Admin::PauseTypePresenter.new(
          pause_type: pause_type
        ).call
    end

    def create
      pause_type = PauseType.create!(
        pause_type_params
      )

      render json:
        Admin::PauseTypePresenter.new(
          pause_type: pause_type
        ).call,
        status: :created
    end

    def update
      pause_type.update!(
        pause_type_params
      )

      render json:
        Admin::PauseTypePresenter.new(
          pause_type: pause_type
        ).call
    end

    def destroy
      pause_type.destroy!
      head :no_content
    end

    private

    def pause_type
      @pause_type ||= PauseType
        .includes(:team)
        .find(params[:id])
    end

    def pause_type_params
      params
        .require(:pause_type)
        .permit(
          :name,
          :team_id,
          :has_time_limit,
          :max_duration_minutes,
          :max_concurrent,
          :requires_queue,
          :active
        )
    end
  end
end