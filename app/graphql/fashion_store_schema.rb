# frozen_string_literal: true

class FashionStoreSchema < GraphQL::Schema
  query(Types::QueryType)
  mutation(Types::MutationType)

  GraphQL::Batch.use(self)
end
