require 'rails_helper'

module Mutations
  RSpec.describe CreateCartItem, type: :request do
    describe '.resolve' do
      let!(:cart) { create :cart }
      let!(:product) { create :product }
      let(:product_variant) { create :product_variant, product: product }

      let(:quantity) { 2 }
      let(:query) do
        <<~GQL
          mutation {
            createCartItem(input: {productId: #{product.id},
                                   productVariantId: #{product_variant.id},
                                   quantity: #{quantity}} ) {
              cartItem {
                id
                quantity
                productVariant {
                  id
                }
              }
            }
          }
        GQL
      end

      it 'creates a cart_item' do
        expect do
          post '/graphql', params: { query: query }
        end.to change { CartItem.count }.by(1)
      end

      it 'returns a cart_item' do

        post '/graphql', params: { query: query }
        json = JSON.parse(response.body)
        data = json['data']['createCartItem']['cartItem']


        expect(data).to include(
          'id'              => be_present,
          'quantity'        => quantity,
        )
      end
    end
  end
end