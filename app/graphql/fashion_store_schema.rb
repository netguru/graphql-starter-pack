# frozen_string_literal: true

class FashionStoreSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)
end
