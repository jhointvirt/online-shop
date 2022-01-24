require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @product = Product.new
  end

  it 'is not valid without params' do
    expect(@product).to_not be_valid
  end
end
