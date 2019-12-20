module Types
  class CartType < Types::BaseObject
    field :id, ID, null: false
    field :number_of_items, Integer, null: true
    field :cart_items, [Types::CartItemType], null: true

    def cart_items
      AssociationLoader.for(CartItem, :cart_items).load(object)
    end
  end
end
