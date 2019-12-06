# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductCategory, type: :model do
  it { is_expected.to validate_presence_of(:name) }

  subject { FactoryBot.build(:product_category) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to have_many(:products) }
end
