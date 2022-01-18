class ProductController < ApplicationController
  def index
    render json: pagy(Product.all, items: params[:products_count]), status: 200
  end

  def show
    render json: Product.find(params[:id]), status: 200
  end

  def products_by_category
    categories = Category.find(params[:category_id]).descendant_ids
    products = Product.where(category_id: params[:category_id])
    if categories
      products = Product.where(category_id: categories).or(products)
    end

    render json: pagy(products, items: params[:products_count]), status: 200
  end

  def create
    item = Product.new(item_params)
    if item.save
      render json: { message: 'Create success', result: item }, status: 201
    else
      render json: { result: item.errors }, status: 400
    end
  end

  def update
    item = Product.find(params[:id])
    unless item
      render json: { message: 'Product cannot find' }, status: 404
    end

    result = item.update(item_params)
    if result
      render json: { message: 'Update success', result: result }, status: 200
    else
      render json: { result: result.errors }, status: 400
    end
  end

  def destroy
    result = Product.delete(params[:id])
    if result
      render json: { message: 'Delete success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  private

  def item_params
    params.require(:product).permit(:title, :description, :price, :category_id)
  end
end
