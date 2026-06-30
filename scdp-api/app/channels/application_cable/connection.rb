module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

    def find_verified_user
      token = request.params[:token]

      payload = Auth::JwtService.decode(token)

      User.find(payload["user_id"])
    rescue
      reject_unauthorized_connection
    end
  end
end