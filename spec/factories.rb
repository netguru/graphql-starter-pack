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

  factory :product_variant do
    variant_type { "color" }
    value { "ff0000" }
    label { "red" }
    product
  end

  factory :user do
    sequence(:email) { |n| "user_#{n}@email.com" }
    password { "123456" }
  end

  factory :cart do
    number_of_items { 1 }
    user
  end

  factory :cart_item do
    quantity { 1 }
    product_variant
    product
    cart
  end
end
