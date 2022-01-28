require 'rails_helper'

RSpec.describe BasketProduct, type: :model do
  before(:each) do
    @user = User.create(email: Faker::Internet.email, username: Faker::Internet.username, password: 'ToStr0nGPa$$w0rD')

    @basket = Basket.create(user: @user)
    @product = Product.create(title: 'BMV', description: 'Good', price: 220.0, category: @category)

    @basket_product = BasketProduct.new
    @basket_product.basket = @basket
    @basket_product.product = @product
  end

  it 'is valid' do
    expect(@basket_product).to be_valid
  end

  it 'is not valid without basket' do
    @basket_product.basket = nil
    expect(@basket_product).to_not be_valid
  end

  it 'is not valid without product' do
    @basket_product.product = nil
    expect(@basket_product).to_not be_valid
  end

  it 'is not valid without params' do
    @basket_product = BasketProduct.new
    expect(@basket_product).to_not be_valid
  end
end
