module Authorizable
  def authorize_manage_users!
    unless current_user.super_admin? ||
           current_user.admin?

      render json: {
        error: "Forbidden"
      }, status: :forbidden
    end
  end
end