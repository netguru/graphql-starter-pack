# frozen_string_literal: true

# simple_query_scenario
# module Types
#   class QueryType < Types::BaseObject
#     field :products,
#           [Types::ProductType],
#           null: false,
#           description: "Returns a list of products in fashion store"
#
#     def products
#       Product.all
#     end
#   end
# end

# more_complex_query_scenario
# field :product_category,
#       Types::ProductCategoryType,
#       null: false,
#       description: "Return product category by ID" do
#         argument :id, ID, required: true
#       end
#
# def product_category(id:)
#   ProductCategory.find(id)
# end

# scenario_12
# field :cart_items,
#       [Types::CartItemType],
#       null: false,
#       description: "Return list of cart_items" do
#         argument :cart_id, ID, required: false
#       end
#
# def cart_items(cart_id: nil)
#   if cart_id.nil?
#     CartItem.all
#   else
#     current_user = context[:current_user]
#
#     cart = Cart.find cart_id
#
#     Authorization.authorize("read_cart_items", { cart: cart, current_user: current_user })
#
#     cart.cart_items
#   end
# end