# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "item-#{n}" }
    price_cents { 1234 }
  end
end
