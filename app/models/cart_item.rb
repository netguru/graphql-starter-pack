class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :product_variant
  belongs_to :cart

  validates_numericality_of :quantity, greater_than_or_equal_to: 1
end
