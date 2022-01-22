class Api::V1::BasketController < ApplicationController
  def initialize
    super
    @basket_service = BasketService.new
  end

  def show
    if current_user
      render json: get_user_basket, status: :ok
    else
      render json: session[:basket], status: :ok
    end
  end

  def add_to_basket
    if params[:product_id] == nil
      render json: { message: 'product id cannot be null' }, status: :not_found
    end

    @basket_product = @basket_service.add_to_basket(params, current_user, session)

    if @basket_product
      render json: { message: 'Add success', result: @basket_product }, status: 201
    else
      render json: { result: @basket_product.errors }, status: 400
    end
  end

  def remove_from_basket
    if params[:product_id] == nil
      render json: { message: 'product_ids cannot be null' }, status: :not_found
    end

    @result = @basket_service.remove(params, current_user, session)

    if @result
      render json: { message: 'Success delete' , data: @result }, status: :ok
    else
      render json: { message: @result }, status: 400
    end
  end

  def basket_count
    if current_user
      render json: BasketProduct.where(basket_id: get_user_basket.id).count, status: :ok
    else
      session[:basket].count
    end
  end

  private

  def get_user_basket
    Basket.where(user_id: current_user.id).first
  end
end
