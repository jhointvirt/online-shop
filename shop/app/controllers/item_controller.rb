class ItemController < ApplicationController
  def index
    render json: pagy(Item.all, items: params[:items_count]), status: 200
  end

  def show
    render json: Item.find(params[:id]), status: 200
  end

  def items_by_category
    categories = Category.find(params[:category_id]).descendant_ids
    items = Item.where(category_id: params[:category_id])
    if categories
      items = Item.where(category_id: categories).or(items)
    end

    render json: pagy(items, items: params[:items_count]), status: 200
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: { message: 'Create success', result: item }, status: 201
    else
      render json: { result: item.errors }, status: 400
    end
  end

  def update
    item = Item.find(params[:id])
    unless item
      render json: { message: 'Item cannot find' }, status: 404
    end

    result = item.update(item_params)
    if result
      render json: { message: 'Update success', result: result }, status: 200
    else
      render json: { result: result.errors }, status: 400
    end
  end

  def destroy
    result = Item.delete(params[:id])
    if result
      render json: { message: 'Delete success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :price, :category_id)
  end
end
