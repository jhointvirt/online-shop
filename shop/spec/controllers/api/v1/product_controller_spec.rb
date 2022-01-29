require 'rails_helper'

RSpec.describe Api::V1::ProductController, type: :controller do
  before(:all) do
    @category = Category.create(title: 'Car')
    @first_product = Product.create(title: 'BMW', description: 'Good', price: 220.0, category: @category)
    @second_product = Product.create(title: 'Audi', description: 'Good', price: 220.0, category: @category)
  end

  describe "GET index" do
    it "returns match array and a ok status code" do
      get :index, :format => :json

      expect(response.status).to eq 200

      body = JSON.parse(response.body)
      products = body[1].map { |i| i['title'] }

      expect(products).to match_array(["BMW", "Audi"])
    end
  end

  describe "GET /:id" do
    it "returns product by id" do
      get :show, params: { id: @first_product.id }

      expect(response.status).to eq 200
    end
  end

  describe "CREATE" do
    it "get forbidden" do
      product = Product.new(title: 'BMW', description: 'Good', price: 220.0, category: @category)

      post :create, params: { product: product }

      expect(response).to have_http_status(:forbidden)
    end

    # it "returns product and ok status code" do
    #   product = Product.new(title: 'BMW', description: 'Good', price: 220.0, category: @category)
    #
    #   post :create, params: { product: product }
    #
    #   expect(response.status).to eq 200
    # end
  end

  describe "UPDATE /:id" do
    it "get forbidden" do
      put :update, params: { id: @first_product.id, product: @second_product }

      expect(response).to have_http_status(:forbidden)
    end

    # it "returns product and ok status code" do
    #   product = Product.new(title: 'BMW', description: 'Good', price: 220.0, category: @category)
    #
    #   post :create, params: { product: product }
    #
    #   expect(response.status).to eq 200
    # end
  end

  describe "DELETE /:id" do
    it "get forbidden" do
      delete :destroy, params: { id: @first_product.id }

      expect(response).to have_http_status(:forbidden)
    end

    # it "destroy by id" do
    #   @user = User.create(email: Faker::Internet.email, username: Faker::Internet.username, password: 'ToStr0nGPa$$w0rD')
    #
    #   delete :destroy, params: { id: @first_product.id }
    #
    #   expect(response).to have_http_status(:ok)
    # end
  end
end
