# frozen_string_literal: true

require "rails_helper"

RSpec.describe "graphql training", type: :request do

  ## What am I doing here?
  #
  # You will learn some graphql.
  # Your training is spit into multiple scenarios. All scenarios are in this file (training_spec.rb).
  # But solving a scenario will require you to visit other places in this application.
  # You must solve scenarios in order starting with scenario 1. When you start a scenario it's tests will be failing.
  # Follow particular scenario instructions add/change application code to make the tests pass.
  # When all scenario tests pass the scenario is done and you can procceed to the next one.
  # 
  #
  ## What is graphql?
  #
  # GraphQL is a query language for your API, and a server-side runtime for executing queries by using a type system
  # you define for your data. GraphQL isn't tied to any specific database or storage engine
  # and is instead backed by your existing code and data.
  #
  ## Literature
  # https://graphql.org/learn/
  # https://graphql-ruby.org/guides
  # 



  # TODO
  #
  # 1. Write all scenarios.
  #
  # 2. Make sure all topics are covered:
  # Types & relations
  # Mutations (create, update, delete)
  # Filters
  # Testing
  # graphql-batch.
  # authentication
  #
  # 3. Comment out application code and mark with labels like: scenario_1



  context "basic" do
    it "queries" do
      shoes = ProductCategory.create!(name: "Shoes")
      otwarty_nosek = Product.create!(name: "Otwarty nosek", price_cents: 1, product_category: shoes)
      Product.create!(name: "Płaski obcas", price_cents: 1, product_category: shoes)
      ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: otwarty_nosek)
      ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: otwarty_nosek)

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
      # todo: comment out application code and mark with label "scenario_1"
      # g-search "scenario_1"


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
      expect(names).to match_array(["Otwarty nosek", "Płaski obcas"])

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
      #

      graphiql_works_for_me = true
      expect(graphiql_works_for_me).to be true

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
      # todo
      # g-search "scenario_3"

      query =
        %(query {
            productCategory(id: #{shoes.id}) {
              name
              products(name: "Otwarty nosek") {
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

      # todo:
      # pagination
      # filters
      # operation name
      # variables
      # https://graphql.org/learn/queries
    end

    it "mutations" do
      cart = Cart.create!(number_of_items: 0)
      shoes = ProductCategory.create!(name: "Shoes")
      otwarty_nosek = Product.create!(name: "Otwarty nosek", price_cents: 1, product_category: shoes)
      black_variant = ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: otwarty_nosek)
      white_variant = ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: otwarty_nosek)

      ## Scenario 100012 - simple create.
      #
      # For creating a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that create records
      #
      # Instructions:
      # todo
      # - g-search "scenario_100012"

      expect(CartItem.count).to eq 0

      query = %(
        mutation {
          createCartItem(input: {productId: #{otwarty_nosek.id},
                                productVariantId: #{white_variant.id},
                                quantity: 2} ) {
            cartItem {
              id
              quantity
              productVariant {
                id
              }
            }
            errors
          }
        }
        )

      post "/graphql", params: { query: query }

      expect(CartItem.count).to eq 1
      cart_item = CartItem.first!
      expect(cart_item.product).to eq otwarty_nosek
      expect(cart_item.product_variant).to eq white_variant
      expect(cart_item.quantity).to eq 2

      ## Scenario 4543 - simple update.
      #
      # To update a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that update records
      #
      # Instructions:
      # todo
      # - g-search "scenario_4543"

      query = %(
          mutation {
            updateCartItem(input: {id: #{cart_item.id},
                                  quantity: 4 } ) {
              cartItem {
                id
                quantity
              }
              errors
            }
          })

      post "/graphql", params: { query: query }

      cart_item.reload
      expect(cart_item.quantity).to eq 4

      ## Scenario 494567 - simple destroy.
      #
      # To destroy a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that destroy records
      #
      # Instructions:
      # todo
      # - g-search "scenario_494567"

      query = %(
          mutation {
            destroyCartItem(input: {id: #{cart_item.id}} ) {
              errors
            }
          })

      post "/graphql", params: { query: query }

      expect(CartItem.count).to eq 0
    end

    context "testing" do
      # todo: https://graphql-ruby.org/testing/overview.html
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
