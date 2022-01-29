require 'rails_helper'

RSpec.describe Api::V1::AuthController, type: :controller do
  before(:all) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.username, password: 'ToStr0nGPa$$w0rD')
  end

  describe "POST login" do
    it "has a 200 status code and valid json" do
      post :login, params: { email: @user.email, password: @user.password }
      result = JSON.parse(response.body)
      expect(response.status).to eq 200
      expect(result).to eq({
                           'success' => result['success'],
                           'user' => result['user'],
                           'access_token' => result['access_token'],
                           'refresh_token' => result['refresh_token']
                         })
    end
  end
  #
  describe "POST refresh" do
    it "get 400" do
      post :login, params: { email: @user.email, password: @user.password }
      result = JSON.parse(response.body)
      request.headers['Authorization'] = result['access_token']

      post :refresh, params: { refresh_token: result['refresh_token'] }
      result = JSON.parse(response.body)
      expect(response.status).to eq 400
      expect(result).to eq({
                             'is_refresh' => false,
                             'access_token' => result['access_token']
                           })
    end
  end
end
