# frozen_string_literal: true

FactoryBot.define do
  factory :product_category do
    sequence(:name) { |n| "category #{n}" }
  end

  factory :product do
    sequence(:name) { |n| "item-#{n}" }
    price_cents { 1234 }
    product_category
  end
end
