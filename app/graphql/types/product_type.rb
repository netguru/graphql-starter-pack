# frozen_string_literal: true

# simple_query_scenario
# module Types
#   class ProductType < Types::BaseObject
#     field :id, ID, null: false
#     field :name, String, null: false
#   end
# end

# more_complex_query_scenario
# field :product_variants, [Types::ProductVariantType], null: true
# def product_variants
#   object.product_variants
# end

# optimization_scenario
# def product_variants
#   AssociationLoader.for(Product, :product_variants).load(object)
# end