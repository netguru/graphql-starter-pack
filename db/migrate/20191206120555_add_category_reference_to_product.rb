class AddCategoryReferenceToProduct < ActiveRecord::Migration[6.0]
  def change
    add_reference :products, :product_category, index: true
  end
end
