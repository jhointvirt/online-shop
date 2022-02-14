require "base64"

class Api::V1::AuthController < ApplicationController
  def initialize
    super
    @auth_services = AuthenticationService.new
  end

  def login
    result = @auth_services.login(user_login_params)
    if result[:success]
      render json: result, status: :ok
    else
      render json: result[:message], status: :not_found
    end
  end

  def refresh
    result = @auth_services.refresh(params, auth_header)
    if result[:is_refresh]
      render json: { is_refresh: true, access_token: result[:access_token], refresh_token: result[:refresh_token], expiry_time: Time.now + 24.hours.to_i }, status: :ok
    else
      render json: { is_refresh: false, access_token: auth_header }, status: :bad_request
    end
  end

  private

  def user_login_params
    params.permit(:email, :password)
  end
end
