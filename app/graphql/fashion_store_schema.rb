# frozen_string_literal: true

class FashionStoreSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)
end
