# scenario_10
# module Authorization
#   class Error < StandardError; end
# 
#   def self.authorize(action, options)
#     case action
#     when "create_cart_item"
#       cart = options[:cart]
#       current_user = options[:current_user]
# 
#       raise Authorization::Error.new unless current_user == cart.user
#     else fail
#     end
#   end
# end

# scenario_11
# when "read_cart_items"
#   cart = options[:cart]
#   current_user = options[:current_user]
# 
#   raise Authorization::Error.new unless current_user == cart.user
