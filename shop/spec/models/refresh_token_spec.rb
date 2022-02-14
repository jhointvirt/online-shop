require 'rails_helper'
require 'securerandom'
require 'faker'

RSpec.describe RefreshToken, type: :model do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.username, password: 'ToStr0nGPa$$w0rD')

    @refresh_token = RefreshToken.new
    @refresh_token.refresh_token = SecureRandom.hex
    @refresh_token.expiry_time = Time.now + 2.hours.to_i
    @refresh_token.user = @user
  end

  it 'is valid' do
    expect(@refresh_token).to be_valid
  end

  it 'is not valid without refresh token' do
    @refresh_token.refresh_token = nil
    expect(@refresh_token).to_not be_valid
  end

  it 'is not valid without expiry time' do
    @refresh_token.expiry_time = nil
    expect(@refresh_token).to_not be_valid
  end

  it 'is not valid without user' do
    @refresh_token.user = nil
    expect(@refresh_token).to_not be_valid
  end

  it 'is not valid without params' do
    @refresh_token = RefreshToken.new
    expect(@refresh_token).to_not be_valid
  end
end
