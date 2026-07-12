module Authenticable
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
  end

  private

  def authenticate_user!
    header = request.headers['Authorization']

    token = header.split(' ').last if header.present?

    if token.blank?
      return render json: {
        error: 'Missing token'
      }, status: :unauthorized
    end

    begin
      payload = Auth::JwtService.decode(token)

      @current_user = User.find(payload["user_id"])
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: {
        error: 'Invalid token'
      }, status: :unauthorized
    end
  end

  def current_user
    @current_user
  end
end