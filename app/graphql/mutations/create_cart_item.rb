# frozen_string_literal: true

module Mutations
  class CreateCartItem < BaseMutation
    argument :product_id, Integer, required: false
    argument :quantity, Integer, required: false
    argument :product_variant_id, Integer, required: false

    field :cart_item, Types::CartItemType, null: true
    field :errors, [String], null: true

    def resolve(product_id:, product_variant_id:, quantity:)
      cart_item = Cart.first.cart_items.new(product_id: product_id,
                                            product_variant_id: product_variant_id,
                                            quantity: quantity)
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
