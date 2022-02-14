class BasketService
  def add_to_basket(params, current_user, session)
    @product = Product.find(params[:product_id])
    if current_user
      add_to_basket_current_user(@product, current_user)
    else
      add_to_basket_anonymous_user(@product, session)
    end

  end

  def remove(params, current_user, session)
    if current_user
      basket = get_user_basket(current_user)
      entity = BasketProduct.where(basket_id: basket.id).where(product_id: params[:product_id]).first
      if entity
        entity.delete
      end

      products = []
      BasketProduct.where(basket_id: basket.id).each do |i|
        products << Product.find(i.product_id)
      end
      products
    else
      index = 0 # need more good way
      session[:basket].each do |i|
        if i['id'] == params[:product_id]
          session[:basket].delete_at(index)
          break
        end
        index = index + 1
      end
      session[:basket]
    end
  end

  private

  def add_to_basket_current_user(product, current_user)
    @basket = get_user_basket(current_user)
    if @basket
      @basket_product = @basket.basket_product.create(:product => product)
      products = []
      BasketProduct.where(basket_id: @basket.id).each do |i|
        products << Product.find(i.product_id)
      end
      products
    end
  end

  def add_to_basket_anonymous_user(product, session)
    session[:basket] ||= []
    session[:basket] << product
  end

  def get_user_basket(current_user)
    Basket.where(user_id: current_user.id).first
  end
end