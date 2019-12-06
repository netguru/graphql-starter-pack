# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price_cents) }
  it { is_expected.to validate_presence_of(:product_category) }

  it { is_expected.to belong_to(:product_category) }
  it { is_expected.to have_many(:product_variants) }
end
