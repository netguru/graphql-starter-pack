# frozen_string_literal: true

class ProductCategory < ApplicationRecord
  has_many :products, dependent: :destroy
  has_many :cart_items 

  validates :name, uniqueness: true, presence: true
end
