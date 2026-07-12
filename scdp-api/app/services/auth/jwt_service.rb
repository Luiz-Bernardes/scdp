module Auth
  class JwtService
    def self.encode(payload)
      JWT.encode(
        payload.merge(exp: 7.days.from_now.to_i),
        ENV["JWT_SECRET_KEY"],
        "HS256"
      )
    end

    def self.decode(token)
      JWT.decode(
        token,
        ENV["JWT_SECRET_KEY"],
        true,
        algorithm: "HS256"
      ).first
    end
  end
end