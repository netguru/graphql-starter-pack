# Graphql Starter Pack

## Project setup

`docker-compose build`

`docker-compose run web rake db:create`

### Seed database
To seed database with example products just run `docker-compose run --rm web rake db:seed`.

### Tests
You can easily run specs on docker using `docker-compose run --rm web rspec spec/`

# Graphql tutorial

## What am I doing here?

This tutorial will teach you Graphql. Reasonable time to go through it is 2 days but tinkering around is encouraged. Tutorial is split into multiple scenarios. All scenarios are in spec/tutorial_spec.rb file.
But solving a scenario will require you to visit other places in this application.
You must solve scenarios in order starting with scenario_1 . When you start a scenario it's tests will be failing.
Follow particular scenario instructions add/change application code to make the tests pass.
When all scenario tests pass the scenario is done and you can procceed to the next one.

## Where do I start?

Clone the repository

`git clone git@github.com:netguru/graphql-starter-pack.git`

Go inside.

`cd graphql-starter-pack`

Make a working branch for yourself

`git checkout -b my_graphql_tutorial`

Open spec/tutorial_spec.rb file in editor and look at scenario_1

Run rspec

`docker-compose run --rm web rspec spec/tutorial_spec.rb`

Follow instructions until scenario_1 passes in rspec

Go to the next scenario!

## What if I dont know what to do? What if I get stuck?

Create an issue in this repository with description of the problem. We will try to help.

## I like it! How can I contribute?

Please click the star button :-)

Create an issue with your ideas for a discusscion.

Or take an issue and make a pull request for it. 

## Literature
https://graphql.org/learn/

https://graphql-ruby.org/guides

https://github.com/Shopify/graphql-batch
   
## Graphiql
You can use [graphiql](http://localhost:3000/graphiql) to test your queries and check documentation.
