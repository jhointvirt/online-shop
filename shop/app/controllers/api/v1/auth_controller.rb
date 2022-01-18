require "base64"

class Api::V1::AuthController < ApplicationController
  skip_before_action :authorized, only: [:login]

  def login
    @user = User.find_by_email(params[:email])
    if @user && @user.authenticate(params[:password])
      access_token = encode_token({ user_id: @user.id, expiry_time: Time.now + 24.hours.to_i })
      refresh_token = Base64.encode64(access_token)

      token = RefreshToken.find_by(user_id: @user.id)
      if token
        RefreshToken.update(refresh_token: refresh_token, expiry_time: Time.now + 31.days.to_i, user_id: @user.id)
      else
        RefreshToken.create(refresh_token: refresh_token, expiry_time: Time.now + 31.days.to_i, user_id: @user.id)
      end
      render json: { user: UserSerializer.new(@user), access_token: access_token, refresh_token: refresh_token }, status: :ok
    else
      render json: { message: 'Invalid email or password', }, status: :unauthorized
    end
  end

  def refresh
    decode = decoded_token
    unless decode
      render json: { is_refresh: false, access_token: auth_header }
    end

    token = RefreshToken.find_by(user_id: decode[0]['user_id'])
    if token.refresh_token != params[:refresh_token] || token.expiry_time < Time.now
      render json: { is_refresh: false, access_token: auth_header }
    end

    access_token = encode_token({user_id: decode[0]['user_id'], expiry_time: Time.now + 24.hours.to_i})
    refresh_token = Base64.encode64(access_token)

    RefreshToken.update(refresh_token: refresh_token, expiry_time: Time.now + 31.days.to_i, user_id: decode[0]['user_id'])

    render json: { is_refresh: true, access_token: access_token, refresh_token: refresh_token, expiry_time: Time.now + 24.hours.to_i }, status: :ok
  end

  private

  def user_login_params
    params.require(:user).permit(:email, :password)
  end
end
