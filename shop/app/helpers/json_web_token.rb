class JsonWebToken
  def self.encode_token(payload)
    JWT.encode(payload, 'wi5i2358g9se85j320khgdg4')
  end

  def self.decoded_token(access_token)
    if access_token
      token = access_token.split(' ')[1]
      begin
        JWT.decode(token, 'wi5i2358g9se85j320khgdg4', true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end
end