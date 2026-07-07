module Pauses
  class PausesController < ApplicationController
    def start
      pause_type = PauseType.find(params[:pause_type_id])

      result = Pauses::StartPauseService.new(
        user: current_user,
        pause_type: pause_type,
        selected_duration_minutes: params[:selected_duration_minutes]
      ).call

      render json: result, status: :created
    rescue StandardError => e
      render json: {
        error: e.message
      }, status: :unprocessable_content
    end

    def finish
      pause = current_user.pauses.active.find(params[:id])

      Pauses::FinishPauseService.new(
        pause: pause
      ).call

      render json: {
        message: 'Pause finished successfully'
      }
    rescue ActiveRecord::RecordNotFound
      render json: {
        error: 'Active pause not found'
      }, status: :not_found
    end

    def current
      pause = current_user.pauses.active.first

      if pause
        render json: pause
      else
        render json: {
          message: 'No active pause'
        }
      end
    end

    def history
      pauses = current_user.pauses
                           .history
                           .order(started_at: :desc)

      render json: pauses
    end
  end
end