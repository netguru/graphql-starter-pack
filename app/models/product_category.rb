# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :name, uniqueness: true, presence: true
end
