# Banking Account Manager

BankingAccountManager is a application to manage bancary account with indication mechanics attached.

The model contains two schemas:

- Client schema responsible to keep client information.
- Account schema  responsible to keep account information.

## Installation and Usage

To run test and coveralls

`$ docker-compose up --build test`

Create database(dev environment) 

`$ docker-compose run dev mix do ecto.create, ecto.migrate`

To run dev enviroment

`$ docker-compose up dev`

Run release(prod environment) of the phoenix server:

`$ docker-compose up release`

## Contributing

1. [Fork it!](https://github.com/danielscosta/banking_account_manager/fork)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

Daniel S. Costa (@danielscosta)

## License

BankingAccountManager is released under the MIT License. See the LICENSE file for further details.