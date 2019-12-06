# frozen_string_literal: true

class AddLabelToProductVariants < ActiveRecord::Migration[6.0]
  def change
    add_column :product_variants, :label, :string, null: false
  end
end
