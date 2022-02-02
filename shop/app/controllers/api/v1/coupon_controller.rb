class Api::V1::CouponController < ApplicationController
  def index
    render json: Coupon.all, status: 200
  end

  def show
    render json: Coupon.find(params[:id]), status: 200
  end

  def create
    coupon = Coupon.new(coupon_params)
    if coupon.save
      render json: { message: 'Create success', result: coupon }, status: 201
    else
      render json: { result: coupon }, status: 400
    end
  end

  def update
    coupon = Coupon.find(params[:id])
    unless coupon
      render json: { message: 'Coupon cannot find' }, status: 404
    end

    result = coupon.update(coupon_params)
    if result
      render json: { message: 'Update success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  def destroy
    result = Coupon.delete(params[:id])
    if result
      render json: { message: 'Delete success', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  def add_used
    @coupon = Coupon.where(code: params[:code]).first
    unless @coupon
      render json: { message: 'Coupon cannot find' }, status: 404
    end

    result = @coupon.update_attribute(:used_count, @coupon.used_count + 1)
    if result
      render json: { message: 'Count add + 1', result: result }, status: 200
    else
      render json: { result: result }, status: 400
    end
  end

  private

  def coupon_params
    params.require(:coupon).permit(:code, :discount, :used_count)
  end
end
