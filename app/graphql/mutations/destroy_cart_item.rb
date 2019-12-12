# frozen_string_literal: true

module Mutations
  class DestroyCartItem < BaseMutation
    argument :id, Integer, required: true

    field :cart_item, Types::CartItemType, null: false
    field :errors, [String], null: false

    def resolve(id:)
      cart_item = CartItem.find(id)
      if cart_item.destroy
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
