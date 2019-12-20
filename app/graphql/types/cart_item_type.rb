# frozen_string_literal: true

module Types
  class CartItemType < Types::BaseObject
    field :id, ID, null: false
    field :quantity, Integer, null: true
    field :product, Types::ProductType, null: true
    field :product_variant, Types::ProductVariantType, null: true

    def product
      RecordLoader.for(Product).load(object.product_id)
    end

    def product_variant
      RecordLoader.for(ProductVariant).load(object.product_variant_id)
    end
  end
end
