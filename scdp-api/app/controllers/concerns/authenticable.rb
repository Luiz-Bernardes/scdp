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
      decoded = JWT.decode(
        token,
        ENV['JWT_SECRET_KEY'],
        true,
        algorithm: 'HS256'
      )

      @current_user = User.find(decoded[0]['user_id'])
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