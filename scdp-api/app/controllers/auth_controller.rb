class AuthController < ApplicationController
  def google
    auth = request.env['omniauth.auth']

    email = auth.info.email
    name = auth.info.name
    google_uid = auth.uid

    pending_membership = TeamMembership.find_by(
      email: email,
      pending: true
    )

    unless pending_membership
      return render json: {
        error: 'User not invited'
      }, status: :forbidden
    end

    user = User.find_or_initialize_by(email: email)

    user.update!(
      name: name,
      google_uid: google_uid
    )

    TeamMembership.where(
      email: email,
      pending: true
    ).find_each do |membership|
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