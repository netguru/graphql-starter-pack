class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :product_variant
  belongs_to :cart
end
