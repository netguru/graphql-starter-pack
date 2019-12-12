# frozen_string_literal: true

module Mutations
  class UpdateCartItem < BaseMutation
    argument :id, Integer, required: true
    argument :product_id, Integer, required: true
    argument :quantity, Integer, required: true
    argument :product_variant_id, Integer, required: false

    field :cart_item, Types::CartItemType, null: false
    field :errors, [String], null: false

    def resolve(id:, **attributes)
      cart_item = CartItem.find(id)
      
      if cart_item.update!(attributes)
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
