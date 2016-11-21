# Walmart Exporter

For prototyping used:
- monolithic app
- postgres
- rails

## Todos
- implement API for `ProductsIndex.filter{ reviews.text == 'XXX' }`
- split into microservices:
  - API
  - products importer. Watching SQS for productID
  - reviews parser.    Watching SQS for productID
- better daemon mode
- Grape for API
- Store products in dynamoDB with dividing into partitions. http://docs.aws.amazon.com/amazondynamodb/latest/developerguide/GuidelinesForTables.html#GuidelinesForTables.Partitions
- replace walmart gem with custom client
- navigate by pages when grabbing reviews

## How to run
  Create ES indexes `docker-compose run app bundle exec rake chewy:reset`
  Run `docker-compose run app bundle exec rake application:fetch_products`

## Hot to test
  `docker-compose run app bundle exec rake`
