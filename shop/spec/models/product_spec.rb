require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @product = Product.new
    @product.title = 'BMW'
    @product.description = 'Some desc'
    @product.price = 228.0
  end

  it 'is not valid without params' do
    expect(@product).to_not be_valid
  end

  it 'is valid' do
    @category = Category.create(title: 'Car')
    @product.category = @category
    expect(@product).to be_valid
  end

  it 'is not valid without category id' do
    @product.category = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid without title' do
    @category = Category.create(title: 'Car')
    @product.category = @category
    @product.title = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid without description' do
    @category = Category.create(title: 'Car')
    @product.category = @category
    @product.description = nil
    expect(@product).to_not be_valid
  end

  it 'is not valid without description' do
    @category = Category.create(title: 'Car')
    @product.category = @category
    @product.price = nil
    expect(@product).to_not be_valid
  end
end
