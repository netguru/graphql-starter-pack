class UserCarts < ActiveRecord::Migration[6.0]
  def change
    add_reference :carts, :user, index: true
  end
end
