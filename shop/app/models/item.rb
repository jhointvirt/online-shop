class Item < ApplicationRecord
  belongs_to :category
  validates :rating, :inclusion => 1..5
end
