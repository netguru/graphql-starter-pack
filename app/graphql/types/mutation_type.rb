# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_cart_item, mutation: Mutations::CreateCartItem
    field :update_cart_item, mutation: Mutations::UpdateCartItem
    field :destroy_cart_item, mutation: Mutations::DestroyCartItem
  end
end
