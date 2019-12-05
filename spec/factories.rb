FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "item-#{n}" }
  end
end
