require "base64"

class Api::V1::UsersController < ApplicationController
  before_action :authorized, only: [:profile]

  def profile
    render json: { user: UserSerializer.new(current_user) }, status: :accepted
  end

  def create
    @user = User.create(user_params)
    if @user.valid?
      @token = encode_token(user_id: @user.id)
      @refresh_token = RefreshToken.create({ refresh_token: Base64.encode64(@token), expiry_time: Time.now + 31.days.to_i, user_id: @user.id })
      SendRegisterEmailJob.perform_later(@user.email)
      render json: { user: UserSerializer.new(@user), access_token: @token, refresh_token: @refresh_token }, status: :created
    else
      render json: { error: 'failed to create user', custom: @user.errors }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :is_admin)
  end

  def refresh_token_params
    params.require(:refresh_token).permit(:refresh_token, :expiry_time, :user)
  end
end
