require 'rails_helper'

RSpec.describe Basket, type: :model do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.username, password: 'ToStr0nGPa$$w0rD')

    @basket = Basket.new
    @basket.user = @user
  end

  it 'is valid' do
    expect(@basket).to be_valid
  end

  it 'is not valid without user' do
    @basket.user = nil
    expect(@basket).to_not be_valid
  end

  it 'is not valid without params' do
    @basket = Basket.new
    expect(@basket).to_not be_valid
  end
end
