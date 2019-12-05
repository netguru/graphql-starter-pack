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
end
