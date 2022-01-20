class Basket < ApplicationRecord
  belongs_to :user
  # has_and_belongs_to_many :products
  has_many :basket_product
  has_many :product, through: :basket_product
end
