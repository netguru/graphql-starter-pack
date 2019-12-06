# frozen_string_literal: true

class ProductVariant < ApplicationRecord
  belongs_to :product

  validates :variant_type, :value, :label, presence: true
end
