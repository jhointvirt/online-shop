class Api::V1::ReviewController < ApplicationController
  def index
    render json: Review.where(product_id: params[:product_id])
  end

  def create
    review = Review.new(review_params)
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

    result = review.update(review_params)
    if result
      render json: { message: 'Update success', result: result }, status: 200
    else
      render json: { result: result.errors }, status: 400
    end
  end

  def destroy
    result = Review.delete(params[:id])
    if result
      render json: { message: 'Delete success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :description, :product_id)
  end
end
