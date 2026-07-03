class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def google
    result = Auth::GoogleLoginService.new(
      auth: request.env['omniauth.auth']
    ).call

    redirect_to result[:redirect_url], allow_other_host: true
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