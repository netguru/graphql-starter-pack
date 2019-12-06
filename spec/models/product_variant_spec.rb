# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductVariant, type: :model do
  it { is_expected.to validate_presence_of(:variant_type) }
  it { is_expected.to validate_presence_of(:value) }
  it { is_expected.to validate_presence_of(:label) }

  it { is_expected.to belong_to(:product) }
end
