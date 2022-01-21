class ApplicationController < ActionController::API
  include Pagy::Backend
  Pagy::DEFAULT[:items] = 25

  def auth_header
    request.headers['Authorization']
  end

  def current_user
    if JsonWebToken.decoded_token(request.headers['Authorization'])
      user_id = JsonWebToken.decoded_token(request.headers['Authorization'])[0]['user_id']
      @user = User.find_by(id: user_id)
    end
  end

  def logged_in?
    !!current_user
  end

  def authorized
    unless logged_in?
      render json: { message: 'Please log in' }, status: :unauthorized
    end
  end

  def admin?
    if !logged_in? || (logged_in? && !@user.is_admin)
      render json: { message: 'Access denied' }, status: 403
    end
  end
end
