# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :price, Integer, null: true
    field :description, String, null: true
    field :product_category, Types::ProductCategoryType, null: true
    field :product_variant, Types::ProductVariantType, null: true
  end
end
