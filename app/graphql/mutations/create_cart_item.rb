# frozen_string_literal: true

# mutation_create_scenario
# module Mutations
#   class CreateCartItem < BaseMutation
#     argument :cart_id, Integer, required: true
#     argument :product_variant_id, Integer, required: true
#     argument :quantity, Integer, required: false
#
#     field :cart_item, Types::CartItemType, null: true
#     field :errors, [String], null: true
#
#     def resolve(cart_id:, product_variant_id:, quantity:)
#       cart = Cart.find cart_id
#
#       variant = ProductVariant.find product_variant_id
#
#       cart_item = CartItem.new(
#         product: variant.product,
#         product_variant: variant,
#         cart: cart,
#         quantity: quantity
#       )
#
#       if cart_item.save
#         {
#           cart_item: cart_item,
#           errors: []
#         }
#       else
#         {
#           cart_item: nil,
#           errors: cart_item.errors.full_messages
#         }
#       end
#     end
#   end
# end

# authorization_scenario
# Authorization.authorize("create_cart_item", { cart: cart, current_user: context[:current_user] })