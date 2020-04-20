# Banking Account Manager

To run test and coveralls

`$ docker-compose run --rm test`

Create database(dev environment) 

`$ docker-compose run dev mix do ecto.create, ecto.migrate`

To run dev enviroment

`$ docker-compose up dev`

Run release(prod environment) of the phoenix server:

`$ docker-compose up release`