module Types
  class CartType < Types::BaseObject
    field :id, ID, null: false
    field :number_of_items, Integer, null: true
    field :cart_items, [Types::CartItemType], null: true
  end
end
