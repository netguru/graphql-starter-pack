# frozen_string_literal: true

# scenario 5
module Mutations
  class UpdateCartItem < BaseMutation
    argument :id, Integer, required: true
    argument :quantity, Integer, required: false
    argument :product_variant_id, Integer, required: false

    field :cart_item, Types::CartItemType, null: false
    field :errors, [String], null: false

    def resolve(id:, quantity: nil, product_variant_id: nil)
      cart_item = CartItem.find(id)

      if product_variant_id
        variant = ProductVariant.find product_variant_id
        cart_item.product_variant = variant
        cart_item.product = variant.product
      end

      if quantity
        cart_item.quantity = quantity
      end
      
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

# original_application_code
# module Mutations
#   class UpdateCartItem < BaseMutation
#     argument :id, Integer, required: true
#     argument :product_id, Integer, required: false
#     argument :quantity, Integer, required: false
#     argument :product_variant_id, Integer, required: false
# 
#     field :cart_item, Types::CartItemType, null: false
#     field :errors, [String], null: false
# 
#     def resolve(id:, **attributes)
#       cart_item = CartItem.find(id)
#       
#       if cart_item.update!(attributes)
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
