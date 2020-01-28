# frozen_string_literal: true

module Types
  class ProductCategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :products, [Types::ProductType], null: false do
      argument :name, String, required: false
    end

    # training hint: this function is a resolver
    def products(name: nil)
      if name.nil?
        object.products
      else
        object.products.where(name: name)
      end
    end
  end
end
