class CategoryController < ApplicationController
  def index
    render json: Category.where(ancestry: nil), status: 200
  end

  def show
    render json: Category.find(params[:id]).children, status: 200
  end

  def create
    category = Category.find(params[:ancestry])
    if category
      params[:category][:ancestry] = "#{category.ancestry}/#{params[:ancestry]}"
    end

    category = Category.new(category_params)
    if category.save
      render json: { message: 'Create success', result: category }, status: 201
    else
      render json: { result: category }, status: 400
    end
  end

  def update
    category = Category.find(params[:id])
    unless category
      render json: { message: 'Category cannot find' }, status: 404
    end

    result = category.update(category_params)
    if result
      render json: { message: 'Update success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  def destroy
    result = Category.delete(params[:id])
    if result
      render json: { message: 'Delete success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  private

  def category_params
    params.require(:category).permit(:title, :ancestry)
  end
end
