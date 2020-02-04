# Fashion Store Backend

## Project setup
### Docker
Projects development environment is dockerized, so just run `docker-compose up`.
### Seed database
To seed database with example products just run `docker-compose run --rm web rake db:seed`.

## Graphql api
Use http://localhost:3000/graphql to post your queries and mutations.

### Graphiql
You can use [graphiql](http://localhost:3000/graphiql) to test your queries and check documentation.

## Tests
You can easily run specs on docker using `docker-compose run --rm web rspec spec/`

# Graphgl  tutorial

## What am I doing here?

Graphql tutorial is a first part of graphql training: https://docs.google.com/document/d/12r7Wy__0DiCEBXxK6pT5GwN_6AUXhPXm4wkN4GPXaIY/edit#

Tutorial is split into multiple scenarios. All scenarios are in spec/tutorial_spec.rb file.
But solving a scenario will require you to visit other places in this application.
You must solve scenarios in order starting with scenario_1 . When you start a scenario it's tests will be failing.
Follow particular scenario instructions add/change application code to make the tests pass.
When all scenario tests pass the scenario is done and you can procceed to the next one.

## Where do I start?
Start by making a working branch for yourself

`git checkout -b my_graphql_tutorial`

Then open spec/tutorial_spec.rb file and start with scenario_1

`docker-compose run --rm web rspec spec/tutorial_spec.rb`
 
## Literature
https://graphql.org/learn/

https://graphql-ruby.org/guides

https://github.com/Shopify/graphql-batch
   