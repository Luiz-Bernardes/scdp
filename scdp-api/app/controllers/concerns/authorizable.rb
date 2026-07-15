module Authorizable

  def authorize_manage_users!
    unless current_user.can?("manage_users")
      render json: {
        error: "Forbidden"
      },
      status: :forbidden
    end
  end

end