# frozen_string_literal: true

module Types
  class ProductVariantType < Types::BaseObject
    field :id, ID, null: false
    field :value, String, null: false
    field :label, String, null: false
    field :variant_type, String, null: false
  end
end
