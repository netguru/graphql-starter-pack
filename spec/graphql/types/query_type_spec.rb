# frozen_string_literal: true

require "rails_helper"

RSpec.describe Types::QueryType do
  describe "products" do
    let!(:products) { create_pair(:product) }

    let(:query) do
      %(query {
        products {
          name
        }
      })
    end

    subject(:result) do
      FashionStoreSchema.execute(query).as_json
    end

    it "returns all items" do
      expect(result.dig("data", "products")).to match_array(
        products.map { |product| { "name" => product.name } }
      )
    end
  end

  describe "product" do
    let!(:product) { create(:product) }

    let(:query) do
      %(query {
        product(id: #{product.id}) {
          name
        }
      })
    end

    subject(:result) do
      FashionStoreSchema.execute(query).as_json
    end

    it "returns item with given id" do
      expect(result["data"]["product"]["name"]).to eq(product.name)
    end
  end
end
