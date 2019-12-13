require 'rails_helper'

module Mutations
  RSpec.describe DestroyCartItem, type: :request do
    describe '.resolve' do
      let!(:cart_item) { create :cart_item }

      subject { post '/graphql', params: { query: query } } 

      context 'With valid params' do 
        let(:query) do
          <<~GQL
            mutation {
              destroyCartItem(input: {id: #{cart_item.id}} ) {
                errors
              }
            }
          GQL
        end

        it 'deletes a cart_item' do
          expect { subject }.to change(CartItem, :count).by(-1)
        end

        it 'should return no errors' do
          subject
          json = JSON.parse(response.body)
          errors = json['data']['destroyCartItem']['errors']
          expect(errors).to be_empty
        end
      end
    end
  end
end