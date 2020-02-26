# frozen_string_literal: true

# scenario_1
# module Types
#   class ProductType < Types::BaseObject
#     field :id, ID, null: false
#     field :name, String, null: false
#   end
# end

# scenario_3
# field :product_variants, [Types::ProductVariantType], null: true
# def product_variants
#   object.product_variants
# end

# scenario_9
# def product_variants
#   AssociationLoader.for(Product, :product_variants).load(object)
# end