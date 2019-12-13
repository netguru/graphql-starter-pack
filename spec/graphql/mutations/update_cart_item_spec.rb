require 'rails_helper'

module Mutations
  RSpec.describe UpdateCartItem, type: :request do
    describe '.resolve' do
      let(:quantity_1) { 2 }
      let(:quantity_2) { quantity_1 + 1 }
      let!(:cart_item) { create :cart_item, quantity: quantity_1 }

      subject { post '/graphql', params: { query: query } } 

      context 'With valid params' do 
        let(:query) do
          <<~GQL
            mutation {
              updateCartItem(input: {id: #{cart_item.id},
                                    quantity: #{quantity_2}} ) {
                cartItem {
                  id
                  quantity
                }
                errors
              }
            }
          GQL
        end

        it 'creates a cart_item' do
          expect { subject }.to change{CartItem.last.quantity}.to(quantity_2)
        end

        it 'returns a cart_item' do
          subject
          json = JSON.parse(response.body)
          data = json['data']['updateCartItem']['cartItem']

          expect(data).to include(
            'id'              => be_present,
            'quantity'        => quantity_2,
          )
        end

        it 'should return no errors' do
          subject
          json = JSON.parse(response.body)
          errors = json['data']['updateCartItem']['errors']
          expect(errors).to be_empty
        end
      end
    end
  end
end