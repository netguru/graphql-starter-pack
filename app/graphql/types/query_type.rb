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

    field :carts,
          [Types::CartType],
          null: false,
          description: "Returns a list of carts"

    field :cart,
          Types::CartType,
          null: false,
          description: "Return cart by ID" do
            argument :id, ID, required: true
          end

    field :cart_item,
          Types::CartItemType,
          null: false,
          description: "Return cart item by ID" do
            argument :id, ID, required: true
          end

    field :cart_items,
          [Types::CartItemType],
          null: false,
          description: "Return list of cart_items"

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
      Product.lazy_preload(:product_category, :product_variants)
    end

    def carts
      Cart.all
    end

    def cart(id:)
      Cart.find(id)
    end

    def cart_items
      CartItem.all
    end

    def cart_item(id:)
      CartItem.find(id)
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
