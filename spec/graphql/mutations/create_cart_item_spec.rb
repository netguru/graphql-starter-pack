require 'rails_helper'

module Mutations
  RSpec.describe CreateCartItem, type: :request do
    describe '.resolve' do
      let!(:cart) { create :cart }
      let!(:product) { create :product }
      let(:product_variant) { create :product_variant, product: product }
      let(:quantity) { 2 }

      subject { post '/graphql', params: { query: query } } 

      context 'With valid params' do 
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
                errors
              }
            }
          GQL
        end

        it 'creates a cart_item' do
          expect { subject }.to change(CartItem, :count).by(1)
        end

        it 'returns a cart_item' do
          subject
          json = JSON.parse(response.body)
          data = json['data']['createCartItem']['cartItem']

          expect(data).to include(
            'id'              => be_present,
            'quantity'        => quantity,
          )
        end

        it 'should return no errors' do
          subject
          json = JSON.parse(response.body)
          errors = json['data']['createCartItem']['errors']
          expect(errors).to be_empty
        end
      end

      context 'With invalid params' do
        let(:query) do
          <<~GQL
          mutation {
            createCartItem(input: {productId: 100,
                                  productVariantId: 100,
                                  quantity: 100} ) {
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
        GQL
        end

        it 'should return errors' do
          subject
          json = JSON.parse(response.body)
          errors = json['data']['createCartItem']['errors']
          expect(errors.count).to eq(2)
        end
      end
    end
  end
end