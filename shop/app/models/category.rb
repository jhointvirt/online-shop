class Category < ApplicationRecord
  has_ancestry

  validates :title, presence: true
end
