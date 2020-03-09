# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # scenario_2
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end

  root to: "graphql#index"

  # simple_query_scenario
  #
  # Notice:
  # In GraphQL, you'll provide a JSON-encoded body whether
  # you're performing a query or a mutation, so the HTTP verb is POST.
  # It's possible to be done with GET verb too, but the disadvantage is that
  # you need to send a query or a mutation in a query string as part of an URL.
  # GitHub, Shopify use only POST endpoints for that purpose in their APIs.
  #
  # post "/graphql", to: "graphql#execute"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
