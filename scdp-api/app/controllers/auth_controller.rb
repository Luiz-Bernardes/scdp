class AuthController < ApplicationController
  skip_before_action :authenticate_user!

  def google
    auth = request.env['omniauth.auth']

    email = auth.info.email
    name = auth.info.name
    provider_uid = auth.uid

    membership = TeamMembership.find_by(email: email)

    unless membership
      return render json: {
        error: 'User not invited'
      }, status: :forbidden
    end

    user = User.find_or_initialize_by(email: email)

    user.update!(
      name: name,
      provider: 'google',
      provider_uid: provider_uid
    )

    TeamMembership.where(email: email).find_each do |membership|
      membership.update!(
        user: user,
        pending: false
      )
    end

    token = Auth::JwtService.encode(
      user_id: user.id
    )

    render json: {
      token: token,
      user: user
    }
  end

  def failure
    render json: {
      error: 'Authentication failed'
    }, status: :unauthorized
  end
end