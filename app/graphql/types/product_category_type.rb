# frozen_string_literal: true

module Types
  class ProductCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :products, [Types::ProductType], null: false
  end
end
