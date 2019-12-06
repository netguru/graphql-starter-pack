# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :products,
          [Types::ProductType],
          null: false,
          description: "Returns a list of products in fashion store"

    field :product,
          Types::ProductType,
          null: false,
          description: "Return product by ID" do
            argument :id, ID, required: true
          end

    def products
      Product.all
    end

    def product(id:)
      Product.find(id)
    end
  end
end
