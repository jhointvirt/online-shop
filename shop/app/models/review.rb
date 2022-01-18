class Review < ApplicationRecord
  belongs_to :item
  validates :rating, :inclusion => 1..5
end
