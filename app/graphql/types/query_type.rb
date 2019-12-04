module Types
  class QueryType < Types::BaseObject
    field :products,
          [Types::ProductType],
          null: false,
          description: "Returns a list of products in fashion store"

    def products
      Product.all
    end
  end
end
