class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :rating, presence: true, :inclusion => 1..5
  validates :description, presence: true
  validates :product_id, presence: true
end
