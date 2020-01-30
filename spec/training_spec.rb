# frozen_string_literal: true

require "rails_helper"

RSpec.describe "graphql training", type: :request do
  # TODO: 1. Write all scenarios.
  #
  # TODO: 2. Make sure all topics are covered:
  # Types & relations
  # Mutations (create, update, delete)
  # Filters
  # Testing
  # graphql-batch.
  # authentication
  #
  # TODO: 3. Write instructions for scenarios. Comment out application code and mark with labels like: scenario_1

  context "basic" do
    context "queries" do
      let(:shoes) { ProductCategory.create!(name: "Shoes") }
      let(:open_nose) { Product.create!(name: "Open nose", price_cents: 1, product_category: shoes) }
      let!(:flat) { Product.create!(name: "Flat", price_cents: 1, product_category: shoes) }
      let!(:white_variant) { ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: open_nose) }
      let!(:black_variant) { ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: open_nose) }

      ## Scenario 1 - make simple query work.
      #
      # Lets start with a simple query.
      #
      # You will learn:
      # - Graphql schema
      # - Query type
      # - Model type
      # - Fields
      #
      # Instructions:
      # TODO: comment out application code and mark with label "scenario_1"
      # g-search "scenario_1"

      it "scenario_1" do
        query = 
          %(query {
              products {
                name
              }
            }
          )

        post "/graphql", params: { query: query }

        result = JSON.parse(response.body)

        names = result.dig("data", "products").map { |product| product["name"] }
        expect(names).to match_array(["Open nose", "Flat"])
      end

      ## Scenario 2 - graphiql simple use.
      #
      # Graphiql is a console available from webpage.
      # Allows to query directly with graphql engine, very helpfull during development.
      #
      # You will learn:
      # - graphiql tool 
      #
      # Instructions:
      # - go to http://localhost:3000/graphiql and query "{ products { name } }" .

      it "scenario_2" do
        graphiql_works_for_me = true
        expect(graphiql_works_for_me).to be true
      end

      ## Scenario 3 - make not that simple query work.
      #
      # Lets try a not that simple query.
      #
      # You will learn:
      # - Filtering
      # - Resolvers
      # - Arguments
      #
      # Instructions:
      # TODO 
      # g-search "scenario_3"

      it "scenario_3" do
        query =
          %(query {
              productCategory(id: #{shoes.id}) {
                name
                products(name: "Open nose") {
                  name
                  productVariants {
                    label
                  }
                }
              }
            })
      
        post "/graphql", params: { query: query }

        result = JSON.parse(response.body)

        expect(result["data"]).to be_present
        expect(result.dig("data", "productCategory")).to be_present
        expect(result.dig("data", "productCategory", "products")).to be_present
        variants = result.dig("data", "productCategory", "products").flat_map { |product| product["productVariants"] }
        expect(variants).to be_present
        labels = variants.flat_map { |variant| variant["label"] } 
        expect(labels).to match_array(["white", "black"])
      end

      # TODO:
      # pagination
      # filters
      # operation name
      # variables
      # https://graphql.org/learn/queries
    end

    context "mutations" do
      let!(:cart) { Cart.create!(number_of_items: 0) }
      let(:shoes) { ProductCategory.create!(name: "Shoes") }
      let!(:open_nose) { Product.create!(name: "Open nose", price_cents: 1, product_category: shoes) }
      let!(:black_variant) { ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: open_nose) }
      let!(:white_variant) { ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: open_nose) }

      ## Scenario 100012 - simple create.
      #
      # For creating a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that create records
      #
      # Instructions:
      # TODO
      # - g-search "scenario_100012"

      it "scenario_100012" do
        query = %(
          mutation {
            createCartItem(
              input: {
                productId: #{open_nose.id},
                productVariantId: #{white_variant.id},
                quantity: 2
              }
            ) {
              cartItem {
                id
                quantity
                productVariant {
                  id
                }
              }
              errors
            }
          })

        post "/graphql", params: { query: query }

        expect(CartItem.count).to eq 1
        cart_item = CartItem.first!
        expect(cart_item.product).to eq open_nose
        expect(cart_item.product_variant).to eq white_variant
        expect(cart_item.quantity).to eq 2
      end

      ## Scenario 4543 - simple update.
      #
      # To update a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that update records
      #
      # Instructions:
      # TODO
      # - g-search "scenario_4543"

      it "scenario_4543" do
        cart_item = CartItem.create!(quantity: 1, product: open_nose, product_variant: white_variant, cart: cart )

        query = %(
            mutation {
              updateCartItem(
                input: {
                  id: #{cart_item.id},
                  quantity: 4
                }
              ) {
                cartItem {
                  id
                  quantity
                }
                errors
              }
            })

        post "/graphql", params: { query: query }

        expect(cart_item.reload.quantity).to eq 4
      end

      ## Scenario 494567 - simple destroy.
      #
      # To destroy a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that destroy records
      #
      # Instructions:
      # TODO
      # - g-search "scenario_494567"

      it "scenario_494567" do
        cart_item = CartItem.create!(quantity: 1, product: open_nose, product_variant: white_variant, cart: cart )

        query = %(
            mutation {
              destroyCartItem(
                input: {
                  id: #{cart_item.id}
                }
              ) {
                errors
              }
            })

        post "/graphql", params: { query: query }

        expect(CartItem.count).to eq 0
      end
    end

    context "testing" do
      # TODO: https://graphql-ruby.org/testing/overview.html
    end
  end

  context "advanced" do
    context "optimizing queries" do
      it "graphql-batch" do
        # https://github.com/Shopify/graphql-batch
        pending
      end

      it "DataLoader" do
        # https://www.youtube.com/watch?v=OQTnXNCDywA
        # https://github.com/graphql/dataloader
        pending
      end
    end

    context "auth" do
      # https://graphql-ruby.org/authorization/overview.html
      # js seems involved: https://graphql.org/learn/authorization/

      it "authentication" do
        pending
      end

      it "authorization" do
        pending
      end
    end
  end
end
