# frozen_string_literal: true

module Types
  class ProductType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :price, Integer, null: true
    field :description, String, null: true
    field :product_category, Types::ProductCategoryType, null: true
    field :product_variants, [Types::ProductVariantType], null: true

    def product_category
      RecordLoader.for(ProductCategory).load(object.product_category_id)
    end

    # TODO: decide whether to use pure graphql-batch or the AssociationsLoader extenssion?
    # AssociationLoader docs: https://github.com/Shopify/graphql-batch
    def product_variants
      AssociationLoader.for(Product, :product_variants).load(object)
    end
  end
end
