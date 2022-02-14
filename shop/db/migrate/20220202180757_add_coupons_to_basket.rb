class AddCouponsToBasket < ActiveRecord::Migration[7.0]
  def change
    add_reference :baskets, :coupon, null: true, foreign_key: true
  end
end
