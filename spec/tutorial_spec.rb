# frozen_string_literal: true

require "rails_helper"

RSpec.describe "graphql tutorial", type: :request do
  context "basic" do
    context "queries" do
      let(:shoes) { ProductCategory.create!(name: "Shoes") }
      let(:open_nose) { Product.create!(name: "Open nose", price_cents: 1, product_category: shoes) }
      let!(:flat) { Product.create!(name: "Flat", price_cents: 1, product_category: shoes) }
      let!(:adidas) { Product.create!(name: "Adidas", price_cents: 1, product_category: shoes) }
      let!(:nike) { Product.create!(name: "Nike", price_cents: 1, product_category: shoes) }
      let!(:white_variant) { ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: open_nose) }
      let!(:black_variant) { ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: open_nose) }

      ## Scenario 1 - make simple query work.
      #
      # Lets start with a simple query.
      #
      # You will learn:
      # - Graphql schema
      # - Query type
      # - BaseObject type
      # - Fields
      #
      # Instructions:
      # - g-search scenario_1

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
        expect(names).to match_array(["Open nose", "Flat", "Adidas", "Nike"])
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
      # - g-search scenario_2
      # - run `docker-compose up`
      # - go to http://localhost:3000/graphiql
      # - query `{ products { name } }` .

      it "scenario_2" do
        graphiql_works_for_me = false
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
      # operation name
      # variables
      # https://graphql.org/learn/queries

      # scenario_4 - pagination
      # dont do global search, read:
      # https://graphql.org/learn/pagination/
      # https://www.2n.pl/blog/graphql-pagination-in-rails
      # and add productConnection to Query

      it 'scenario_4 - queries for only 2 products' do
        query =
          %(query {
            productsConnection(first: 2) {
              pageInfo {
                startCursor
                endCursor
                hasNextPage
                hasPreviousPage
              }
              edges {
                cursor
                node {
                  id
                  name
                  productVariants {
                    id
                  }
                }
              }
            }
          })

        post "/graphql", params: { query: query }

        result = JSON.parse(response.body)

        expect(result["data"]).to be_present
        expect(result.dig("data", "productsConnection")).to be_present
        expect(result.dig("data", "productsConnection", "edges").count).to eq 2
      end
    end

    context "mutations" do
      let(:user) { create :user }
      let!(:cart) { Cart.create!(number_of_items: 0, user: user) }
      let(:shoes) { ProductCategory.create!(name: "Shoes") }
      let!(:open_nose) { Product.create!(name: "Open nose", price_cents: 1, product_category: shoes) }
      let!(:black_variant) { ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: open_nose) }
      let!(:white_variant) { ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: open_nose) }

      ## Scenario 5 - simple create.
      #
      # For creating a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that create records
      #
      # Instructions:
      # - g-search scenario_5

      it "scenario_5" do
        query = %(
          mutation {
            createCartItem(
              input: {
                cartId: #{cart.id},
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

      ## Scenario 6 - simple update.
      #
      # To update a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that update records
      #
      # Instructions:
      # - g-search scenario_6

      it "scenario_6" do
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

      ## Scenario 7 - simple destroy.
      #
      # To destroy a record you need to write a mutation.
      #
      # You will learn:
      # - mutations that destroy records
      #
      # Instructions:
      # - g-search scenario_7

      it "scenario_7" do
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

    ## Scenario 8 - testing, make sure schema diff is present in PR.
    #
    # It is possible to generate a schema for graphql queries and mutations. Since any changes to this schema
    # could break clients queries it is a good practice to have a graphql schema diff in PRs.
    #
    # You will learn:
    # - Generating graphql schema with a rake task.
    #
    # Instructions:
    # - g-search scenario_8
    # - run `docker-compose run --rm web rake dump_graphql_schema`

    context "testing" do
      it "scenario_8" do
        current_schema = FashionStoreSchema.to_definition
        schema_archive = File.read(Rails.root.join("app/graphql/schema.graphql")) rescue nil
        expect(current_schema).to eq(schema_archive), "Update the graphql schema with `bundle exec rake dump_graphql_schema`"
      end
    end
  end

  context "advanced" do
    context "optimizing queries" do
      let(:shoes) { ProductCategory.create!(name: "Shoes") }
      let(:open_nose) { Product.create!(name: "Open nose", price_cents: 1, product_category: shoes) }
      let(:flat) { Product.create!(name: "Flat", price_cents: 1, product_category: shoes) }
      let(:track) { Product.create!(name: "Track", price_cents: 1, product_category: shoes) }
      let!(:white_variant) { ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: open_nose) }
      let!(:black_variant) { ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: open_nose) }
      let!(:red_variant) { ProductVariant.create!(variant_type: "color", value: "000fff", label: "red", product: flat) }
      let!(:violet_variant) { ProductVariant.create!(variant_type: "color", value: "fff000", label: "violet", product: flat) }
      let!(:grey_variant) { ProductVariant.create!(variant_type: "color", value: "f0000f", label: "grey", product: track) }

      ## Scenario 9 - fix n+1 on querying associated records.
      #
      # Graphql default strategy for querying will result in n+1 queries in some cases.
      # You will optimize the querying strategy for a case of associated records in this scenario.
      #
      # You will learn:
      # - graphql-batch gem and AssociationLoader pattern
      #
      # Instructions:
      # - g-search scenario_9

      it "scenario_9" do
        query =
          %(query {
              products {
                name
                productVariants {
                  label
                }
              }
            })

        number_of_sql_queries = 0
        counter = lambda do |*args|
          number_of_sql_queries = number_of_sql_queries + 1
          # puts args[4][:sql]
        end
        ActiveSupport::Notifications.subscribed(counter, "sql.active_record") do
          post "/graphql", params: { query: query }
        end

        result = JSON.parse(response.body)

        expect(result["data"]).to be_present
        expect(result.dig("data", "products")).to be_present
        products = result.dig("data", "products")
        variants = products.flat_map { |product| product["productVariants"] }
        expect(variants).to be_present
        labels = variants.flat_map { |variant| variant["label"] }
        expect(labels).to match_array(["white", "black", "red", "violet", "grey"])
        expect(number_of_sql_queries).to eq 2
      end

      # TODO:
      it "DataLoader" do
        # https://www.youtube.com/watch?v=OQTnXNCDywA
        # https://github.com/graphql/dataloader
        pending
      end
    end

    context "auth" do
      ## Scenario 10 - authentication options.
      #
      # Graphql does not provide any solution for authentication. Just use devise current_user.
      #
      # You will learn:
      # - How a graphql query can access current user.
      #
      # Instructions:
      # - g-search scenario_10

      it "scenario_10" do
        user = User.create!(email: "user@email.com", password: "123456")
        sign_in user

        current_user_in_context = nil
        allow(FashionStoreSchema).to receive(:execute) do |*args|
          current_user_in_context = args[1][:context][:current_user]
        end

        post "/graphql"

        expect(current_user_in_context).to eq user
      end

      context "authorization" do
        let!(:rick) { User.create!(email: "rick@email.com", password: "123456") }
        let!(:morty) { User.create!(email: "morty@email.com", password: "123456") }
        let!(:cart) { Cart.create!(number_of_items: 0, user: rick) }
        let(:shoes) { ProductCategory.create!(name: "Shoes") }
        let!(:open_nose) { Product.create!(name: "Open nose", price_cents: 1, product_category: shoes) }
        let!(:black_variant) { ProductVariant.create!(variant_type: "color", value: "000000", label: "black", product: open_nose) }
        let!(:white_variant) { ProductVariant.create!(variant_type: "color", value: "ffffff", label: "white", product: open_nose) }

        context "mutations" do
          ## Scenario 11 - cant add item to another's user cart.
          #
          # Allowing/disallowing a query based on user permissions.
          #
          # You will learn:
          # - How to authorize a mutatuon.
          #
          # Instructions:
          # - g-search scenario_11

          it "scenario_11" do
            sign_in morty

            query = %(
              mutation {
                createCartItem(
                  input: {
                    cartId: #{cart.id},
                    productVariantId: #{white_variant.id},
                    quantity: 2
                  }
                ) {
                  errors
                }
              })

            post "/graphql", params: { query: query }

            expect(CartItem.count).to eq 0
            expect(response). to have_http_status(401)
          end
        end

        context "queries" do
          ## Scenario 12 - cant query another user's cart items.
          #
          # Allowing/disallowing a query based on user permissions.
          #
          # You will learn:
          # - How to authorize a query.
          #
          # Instructions:
          # - g-search scenario_12

          it "scenario_12" do
            query =
              %(query {
                  cartItems(cartId: #{cart.id}) {
                    product {
                      name
                    }
                  }
                })

            post "/graphql", params: { query: query }

            result = JSON.parse(response.body)

            expect(result["data"]).to be_empty
            expect(response). to have_http_status(401)
          end
        end
      end
    end

    # TODO
    # a scenario with some basic stuff with graphql-client
    # https://github.com/github/graphql-client
  end
end
