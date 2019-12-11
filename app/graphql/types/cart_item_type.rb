# frozen_string_literal: true

module Types
  class CartItemType < Types::BaseObject
    field :id, ID, null: false
    field :quantity, Integer, null: true
    field :product, Types::ProductType, null: true
    field :product_variant, Types::ProductVariantType, null: true
  end
end
