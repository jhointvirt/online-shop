class CategoryController < ApplicationController
  def index
    render json: Category.where(ancestry: nil)
  end

  def show
    render json: Category.find(params[:id]).children
  end

  def create
    category = Category.where(id: params[:ancestry]).first
    if category
      params[:category][:ancestry] = "#{category.ancestry}/#{params[:ancestry]}"
    end

    category = Category.new(category_params)
    if category.save
      render json: { message: 'Create success', result: category }, status: 201
    else
      render json: { message: category.errors.full_message }, status: 400
    end
  end

  def update
  end

  def destroy
  end

  private

  def category_params
    params.require(:category).permit(:title, :ancestry)
  end
end
