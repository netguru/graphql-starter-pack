# frozen_string_literal: true

# scenario_5
# module Types
#   class CartItemType < Types::BaseObject
#     field :id, ID, null: false
#     field :quantity, Integer, null: true
#     field :product_variant, Types::ProductVariantType, null: true
#
#     def product_variant
#       object.product_variant
#     end
#   end
# end

# scenario_12
# field :product, Types::ProductType, null: true
#
# def product
#   RecordLoader.for(Product).load(object.product_id)
# end
