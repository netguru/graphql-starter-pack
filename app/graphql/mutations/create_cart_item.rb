# frozen_string_literal: true

module Mutations
  class CreateCartItem < BaseMutation
    argument :product_id, Integer, required: false
    argument :quantity, Integer, required: false
    argument :product_variant_id, Integer, required: false

    field :cart_item, Types::CartItemType, null: true
    field :errors, [String], null: true

    def resolve(product_id:, product_variant_id:, quantity:)
      cart = Cart.first!

      Authorization.authorize("create_cart_item", { cart: cart, current_user: context[:current_user] })

      cart_item = CartItem.new(
        product_id: product_id,
        product_variant_id: product_variant_id,
        quantity: quantity,
        cart: cart
      )
      
      if cart_item.save
        {
          cart_item: cart_item,
          errors: []
        }
      else
        {
          cart_item: nil,
          errors: cart_item.errors.full_messages
        }
      end
    end
  end
end
