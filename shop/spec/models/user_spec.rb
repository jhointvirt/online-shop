require 'rails_helper'
require 'faker'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.new
    @user.email = Faker::Internet.email
    @user.username = Faker::Internet.username
    @user.password = 'ToStr0nGPa$$w0rD'
  end

  it 'is valid' do
    @user = User.new
    @user.email = Faker::Internet.email
    @user.username = Faker::Internet.username
    @user.password = 'ToStr0nGPa$$w0rD'
    expect(@user).to be_valid
  end

  it 'is not valid without params' do
    @user = User.new
    expect(@user).to_not be_valid
  end

  it 'is not valid with bad email' do
    @user.email = 'someRandom'
    expect(@user).to_not be_valid
  end

  it 'is not valid without email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid with bad length password' do
    @user.password = '12345'
    expect(@user).to_not be_valid
  end

  it 'is not valid without username' do
    @user.username = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid with duplicate username' do
    @user.save
    @user = User.new
    @user.email = 'new_test@gmail.com'
    @user.username = 'test_username'
    @user.password = 'ToStr0nGPa$$w0rD'
    expect(@user).to_not be_valid
  end

  it 'is not valid with duplicate email' do
    @user.save
    @user = User.new
    @user.email = 'test@gmail.com'
    @user.username = 'new_test_username'
    @user.password = 'ToStr0nGPa$$w0rD'
    expect(@user).to_not be_valid
  end
end
