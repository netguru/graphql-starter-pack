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

    field :product_categories,
          [Types::ProductCategoryType],
          null: false,
          description: "Returns a list of categories in fashion store"

    field :product_category,
          Types::ProductCategoryType,
          null: false,
          description: "Return product category by ID" do
            argument :id, ID, required: true
          end

    def products
      Product.all
    end

    def product(id:)
      Product.find(id)
    end

    def product_categories
      ProductCategory.all
    end

    def product_category(id:)
      ProductCategory.find(id)
    end
  end
end
