require 'rails_helper'
require 'faker'

RSpec.describe Review, type: :model do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.username, password: 'ToStr0nGPa$$w0rD')
    @category = Category.create(title: 'Car')
    @product = Product.create(title: 'BMV', description: 'Good', price: 220.0, category: @category)

    @review = Review.new
    @review.rating = 5
    @review.description = 'sdasdasdasdasdsadasds'
    @review.product = @product
    @review.user = @user
  end

  it 'is valid' do
    expect(@review).to be_valid
  end

  it 'is not valid without user' do
    @review.user = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid without product' do
    @review.product = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid without description' do
    @review.description = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid without rating' do
    @review.rating = nil
    expect(@review).to_not be_valid
  end

  it 'is not valid with rating more than 5' do
    @review.rating = 6
    expect(@review).to_not be_valid
  end

  it 'is not valid with rating less than 1' do
    @review.rating = 0
    expect(@review).to_not be_valid
  end

  it 'is not valid without params' do
    @review = Review.new
    expect(@review).to_not be_valid
  end
end
