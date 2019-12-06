# frozen_string_literal: true

class AddPriceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :price_cents, :integer, null: false
  end
end
