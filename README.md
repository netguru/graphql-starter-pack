# Fashion Store Backend

## Project setup
### Docker
Projects development environment is dockerized, so just run `dokcer-compose up`.
### Seed database
To seed database with example products just run `docker-compose run --rm web rake db:seed`.

## Graphql api
Use http://localhost:3000/graphql to post your queries and mutations.
### Graphiql
You can use [graphiql](http://localhost:3000/graphiql) to test your queries and check documentation.

## Tests
You can easily run specs on docker using `docker-compose run --rm web rspec spec/`

