module Auth
  class GoogleLoginService
    def initialize(auth:)
      @auth = auth
    end

    def call
      validate_invitation!

      user = find_or_create_user!
      link_memberships!(user)

      {
        token: generate_token(user),
        user: user
      }
    end

    private

    attr_reader :auth

    def email
      auth.info.email
    end

    def name
      auth.info.name
    end

    def provider_uid
      auth.uid
    end

    def validate_invitation!
      unless TeamMembership.exists?(email: email)
        raise Auth::UnauthorizedError, 'User not invited'
      end
    end

    def find_or_create_user!
      user = User.find_or_initialize_by(email: email)

      user.update!(
        name: name,
        provider: 'google',
        provider_uid: provider_uid
      )

      user
    end

    def link_memberships!(user)
      TeamMembership.where(email: email).find_each do |membership|
        membership.update!(
          user: user,
          pending: false
        )
      end
    end

    def generate_token(user)
      Auth::JwtService.encode(
        user_id: user.id
      )
    end
  end
end