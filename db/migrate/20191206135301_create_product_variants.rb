# frozen_string_literal: true

class CreateProductVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :product_variants do |t|
      t.string :variant_type
      t.string :value
      t.references :product, index: true

      t.timestamps
    end
  end
end
