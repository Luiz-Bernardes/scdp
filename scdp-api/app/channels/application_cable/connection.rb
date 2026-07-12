module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      Rails.logger.info "=== ACTION CABLE CONNECT ==="

      self.current_user = find_verified_user

      Rails.logger.info "Connected user: #{current_user.id}"
    end

    private

    def find_verified_user
      token = request.params[:token]

      Rails.logger.info "TOKEN: #{token}"

      payload = Auth::JwtService.decode(token)

      Rails.logger.info "PAYLOAD: #{payload.inspect}"

      User.find(payload["user_id"])
    rescue => e
      Rails.logger.error e.message
      Rails.logger.error e.backtrace.first

      reject_unauthorized_connection
    end
  end
end