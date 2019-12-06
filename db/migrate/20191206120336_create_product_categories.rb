# frozen_string_literal: true

class CreateProductCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :product_categories do |t|
      t.string :name, unique: true, index: true, null: false
      t.timestamps
    end
  end
end
