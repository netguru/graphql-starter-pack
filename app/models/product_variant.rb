# frozen_string_literal: true

class ProductVariant < ApplicationRecord
  belongs_to :product
  has_many :cart_items 

  validates :variant_type, :value, :label, presence: true
end
