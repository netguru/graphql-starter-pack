# frozen_string_literal: true

require "rails_helper"

RSpec.describe "graphql training", type: :request do

  ## Introduction
  #
  # GraphQL is a query language for your API, and a server-side runtime for executing queries by using a type system
  # you define for your data. GraphQL isn't tied to any specific database or storage engine
  # and is instead backed by your existing code and data.
  #
  ## Literature
  # https://graphql.org/learn/
  # https://graphql-ruby.org/guides
  # 

  # Types & relations
  # Mutations (create, update, delete)
  # Filters
  # Testing
  # graphql-batch.
  # authentication

  context "scenarios" do
    context "queries" do
      it "" do
        shoes = ProductCategory.create!(name: "Shoes")
        otwarty_nosek = Product.create!(name: "Otwarty nosek", price_cents: 1, product_category: shoes)
        Product.create!(name: "Płaski obcas", price_cents: 1, product_category: shoes)
        ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: otwarty_nosek)
        ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: otwarty_nosek)

        # First lets make a simple query work.
        # g-search "training_step_1"
        # todo: comment out and mark types when all specs are finished

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

        # Graphiql tool
        # Now when you can run a simple query, go to http://localhost:3000/graphiql and query "{ products { name } }" .
        # This is a console to interact directly with graphql engine, very helpfull during development.
        # graphiql_works_for_me = false
        # expect(graphiql_works_for_me).to be true

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

        labels = result.dig("data", "productCategory", "products")
                      .flat_map { |product| product["productVariants"] }
                      .flat_map { |variant| variant["label"] } 
        expect(labels).to match_array(["white", "black"])

        # todo:
        # pagination
        # filters
        # graphql-batch.
        # operation name
        # variables
        # https://graphql.org/learn/queries
      end

      context "optimized" do
        it "use DataLoader to fix n+1" do
          # DataLoader — Source code walkthrough https://www.youtube.com/watch?v=OQTnXNCDywA
          pending
        end
      end
    end

    context "mutations" do
      it "" do
        cart = Cart.create!(number_of_items: 0)
        shoes = ProductCategory.create!(name: "Shoes")
        otwarty_nosek = Product.create!(name: "Otwarty nosek", price_cents: 1, product_category: shoes)
        black_variant = ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: otwarty_nosek)
        white_variant = ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: otwarty_nosek)

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

        expect(CartItem.count).to eq 0

        # create
        post "/graphql", params: { query: query }

        expect(CartItem.count).to eq 1
        cart_item = CartItem.first!
        expect(cart_item.product).to eq otwarty_nosek
        expect(cart_item.product_variant).to eq white_variant
        expect(cart_item.quantity).to eq 2

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

        # update
        post "/graphql", params: { query: query }

        cart_item.reload
        expect(cart_item.quantity).to eq 4

        query = %(
            mutation {
              destroyCartItem(input: {id: #{cart_item.id}} ) {
                errors
              }
            })

        # destroy
        post "/graphql", params: { query: query }

        expect(CartItem.count).to eq 0
      end
    end

    context "auth" do
      it "authentication" do
      end

      it "authorization" do
        # todo
        # js seems involved: https://graphql.org/learn/authorization/
      end
    end
  end
end
