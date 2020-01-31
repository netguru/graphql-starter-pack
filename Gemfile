# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

gem 'rails', '~> 6.0.1'

gem 'jbuilder', '~> 2.7'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.1'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

gem "graphql", "~> 1.9"
gem 'graphql-batch'

# CORS
gem 'rack-cors'

# Currency
gem 'money-rails', '~>1.12'

gem 'rubocop', require: false

gem 'devise'

group :development do
  gem 'graphiql-rails'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'search_object'
  gem 'search_object_graphql'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem "factory_bot_rails", "~> 5.0"
  gem "rspec-rails"
  gem 'shoulda-matchers'
end

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
