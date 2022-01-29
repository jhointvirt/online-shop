class AuthenticationService
  def login (params)
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      access_token = JsonWebToken.encode_token({ user_id: @user.id, expiry_time: Time.now + 2.hours.to_i })
      refresh_token = Base64.encode64(access_token)

      token = RefreshToken.find_by(user_id: @user.id)
      if token
        RefreshToken.update(refresh_token: refresh_token, expiry_time: Time.now + 31.days.to_i, user_id: @user.id)
      else
        RefreshToken.create(refresh_token: refresh_token, expiry_time: Time.now + 31.days.to_i, user_id: @user.id)
      end
      { success: true, user: UserSerializer.new(@user), access_token: access_token, refresh_token: refresh_token }
    else
      { success: false, message: 'Invalid email or password' }
    end
  end

  def refresh (params, access_token)
    decode = JsonWebToken.decoded_token(access_token)
    unless decode
      return { is_refresh: false, access_token: access_token }
    end

    token = RefreshToken.find_by(user_id: decode[0]['user_id'])
    if token.refresh_token != params[:refresh_token] || token.expiry_time < Time.now
      return { is_refresh: false, access_token: access_token }
    end

    access_token = JsonWebToken.encode_token({user_id: decode[0]['user_id'], expiry_time: Time.now + 2.hours.to_i})
    refresh_token = Base64.encode64(access_token)

    RefreshToken.update(refresh_token: refresh_token, expiry_time: Time.now + 31.days.to_i, user_id: decode[0]['user_id'])

    { is_refresh: true, access_token: access_token, refresh_token: refresh_token, expiry_time: Time.now + 24.hours.to_i }
  end
end