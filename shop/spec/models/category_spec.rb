require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @category = Category.new
  end

  it 'is not valid without title' do
    expect(@category).to_not be_valid
  end

  it 'is valid' do
    @category.title = 'Cars'
    expect(@category).to be_valid
  end
end