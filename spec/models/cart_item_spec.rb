# frozen_string_literal: true

require "rails_helper"

RSpec.describe CartItem, type: :model do
  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }

  it { is_expected.to belong_to(:cart) }
  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:product_variant) }
end
