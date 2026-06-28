module Auth
  class JwtService
    def self.encode(payload)
      JWT.encode(
        payload.merge(exp: 7.days.from_now.to_i),
        ENV['JWT_SECRET_KEY'],
        'HS256'
      )
    end
  end
end