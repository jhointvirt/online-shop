class Api::V1::BasketController < ApplicationController
  def show
    render json: Basket.where(user_id: params[:user_id]).first
  end

  def add_to_basket
    if params[:product_id] == nil
      render json: { message: 'product_id cannot be null' }, status: :not_found
    end

    @product = Product.find(params[:product_id])
    @basket = get_user_basket

    if @basket
      @basket_product = @basket.basket_product.create(:product => @product)
    else
      @basket = current_user.create_basket(product_quantity: 1, total_price: @product.price)
      @basket_product = @basket.basket_product.create(:product => @product)
    end

    if @basket_product
      render json: { message: 'Add success', result: @basket_product }, status: 201
    else
      render json: { result: @basket_product.errors }, status: 400
    end
  end

  def remove_from_basket
    if params[:product_ids] == nil
      render json: { message: 'product_ids cannot be null' }, status: :not_found
    end

    @result = BasketProduct.where(product_id: params[:product_ids]).where(basket_id: get_user_basket.id).delete_all

    if @result
      render json: { message: 'Success delete' , count: @result }, status: 200
    else
      render json: { message: @result.errors }, status: 400
    end
  end

  private

  def get_user_basket
    Basket.where(user_id: current_user.id).first
  end
end
