# frozen_string_literal: true

class Product < ApplicationRecord
  monetize :price_cents, as: :price
  validates :name, :price_cents, :product_category, presence: true

  belongs_to :product_category
  has_many :product_variants
end
