class Product < ApplicationRecord
  belongs_to :category
  # has_and_belongs_to_many :basket
  has_many :basket_product
  has_many :basket, through: :basket_product

  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
end
