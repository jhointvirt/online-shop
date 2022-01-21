class BasketService
  def add_to_basket(params, current_user)
    @product = Product.find(params[:product_id])
    @basket = get_user_basket(current_user)

    if @basket
      @basket_product = @basket.basket_product.create(:product => @product)
    else
      @basket = current_user.create_basket(product_quantity: 1, total_price: @product.price)
      @basket_product = @basket.basket_product.create(:product => @product)
    end
  end

  private

  def get_user_basket(current_user)
    Basket.where(user_id: current_user.id).first
  end
end