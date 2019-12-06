# frozen_string_literal: true

require "rails_helper"

RSpec.describe Types::QueryType do
  subject(:result) do
    FashionStoreSchema.execute(query).as_json
  end

  describe "products" do
    let!(:products) { create_pair :product }

    let(:query) do
      %(query {
        products {
          name
        }
      })
    end

    it "returns all products" do
      expect(result.dig("data", "products")).to match_array(
        products.map { |product| {"name" => product.name} }
      )
    end
  end

  describe "product" do
    let!(:product) { create :product }

    let(:query) do
      %(query {
        product(id: #{product.id}) {
          name
        }
      })
    end

    it "returns item with given id" do
      expect(result["data"]["product"]["name"]).to eq(product.name)
    end
  end

  describe "productCategories" do
    let!(:categories) { create_pair :product_category }

    let(:query) do
      %(query {
        productCategories {
          name
        }
      })
    end

    it "returns all productCategories" do
      expect(result.dig("data", "productCategories")).to match_array(
        categories.map { |category| {"name" => category.name} }
      )
    end
  end

  describe "productCategory" do
    let!(:category) { create(:product_category) }

    let(:query) do
      %(query {
        productCategory(id: #{category.id}) {
          name
        }
      })
    end

    it "returns item with given id" do
      expect(result["data"]["productCategory"]["name"]).to eq(category.name)
    end
  end
end
