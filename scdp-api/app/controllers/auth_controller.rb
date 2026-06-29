class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def google
    result = Auth::GoogleLoginService.new(
      auth: request.env['omniauth.auth']
    ).call

    render json: result
  rescue Auth::UnauthorizedError => e
    render json: {
      error: e.message
    }, status: :forbidden
  end

  def failure
    render json: {
      error: 'Authentication failed'
    }, status: :unauthorized
  end
end