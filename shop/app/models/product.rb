class Product < ApplicationRecord
  belongs_to :category
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true
  validates :price, presence: true
  validates :category_id, presence: true
end
