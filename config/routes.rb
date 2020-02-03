# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  # scenario_2
  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  # end

  root to: "graphql#index"

  # scenario_1
  # post "/graphql", to: "graphql#execute"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
