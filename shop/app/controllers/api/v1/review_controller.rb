class Api::V1::ReviewController < ApplicationController
  before_action :authorized, only: [:create, :update, :destroy]
  def index
    render json: Review.where(product_id: params[:product_id])
  end

  def create
    review = current_user.reviews.new(review_params)
    if review.save
      render json: { message: 'Create success', result: review }, status: 201
    else
      render json: { result: review.errors }, status: 400
    end
  end

  def update
    review = Review.find(params[:id])
    unless review
      render json: { message: 'Review cannot find' }, status: 404
    end

    if review.user_id == current_user.id
      result = review.update(review_params)
      if result
        render json: { message: 'Update success', result: result }, status: 200
      else
        render json: { result: result.errors }, status: 400
      end
    else
        render json: { message: 'Access denied' }, status: 403
    end
  end

  def destroy
    review = Review.find(params[:id])
    if current_user.is_admin || review.user_id == current_user.id
      result = Review.delete(params[:id])
      if result
        render json: { message: 'Delete success', result: result }, status: 200
      else
        render json: { result: result }, status: 400
      end
    else
      render json: { message: 'Access denied' }, status: 403
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end
end
