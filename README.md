# PrivatBankBusinessApi

This gem is an API wrapper for the PrivatBank Business API. It is currently a work in progress. For more details, see the [changelog](CHANGELOG.md).

API documentation can be found [here](https://docs.google.com/document/d/e/2PACX-1vTtKvGa3P4E-lDqLg3bHRF6Wi9S7GIjSMFEFxII5qQZBGxuTXs25hQNiUU1hMZQhOyx6BNvIZ1bVKSr/pub).

This project uses `dry-transformers` and `dry-schema` to provide proper names for API fields. See the model files in the `/models` directory and the mapping from the original fields in the `/transformers` directory. For example, see the [balance transformer](lib/pb_api/transformers/balance_transformer.rb) and [balance model](lib/pb_api/models/balance.rb).

## Installation

Install the gem and add to the application's Gemfile by executing:

```bash
bundle add privat_bank_business_api
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install privat_bank_business_api
```

## Usage

To use the API, you need to initialize the client with your API token. Here is a basic example of how to list balances:

```ruby
require "pb_api"
require "date"

# Initialize the client with your API token
client = PbAPI::Client.new(api_token: "your_api_token_here")

# Define the date range for the balance query
today = Date.today
last_month = today.prev_month

# Fetch the list of balances
balances = client.balance.list(last_month)

# Print the account and balance information
balances.each do |balance|
  puts "Account: #{balance.account}"
  puts "Balance: #{balance.balance_in_money.format}"
end
```

## Feature: Lazy Loading Pagination

All API methods internally use lazy loading to handle paginated results. By leveraging Ruby's Enumerator, the gem fetches data on-demand

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Development Environment

This project includes a development container configuration. To use it, you need to have Visual Studio Code and the Remote - Containers extension installed. You can open the project in a dev container by clicking the badge below:

[![Open in Dev Containers](https://img.shields.io/static/v1?label=Dev%20Containers&message=Open&color=blue&logo=visualstudiocode)](https://vscode.dev/redirect?url=vscode://ms-vscode-remote.remote-containers/cloneInVolume?url=https://github.com/merof-code/privat_bank_business_api)

### API Access Configuration for bin/console

To use the API from the interactive console (`bin/console`), you need to add your own API key. Create a file named `environment.rb` in the root directory and add your API key there. You can use the provided `environment.sample.rb` as a template by renaming it to `environment.rb` and replacing the placeholder with your actual API key.

```ruby
# environment.rb
ENV['API_TOKEN'] = 'your_api_key_here'
```

### Using bin/console

The `bin/console` script provides an interactive Ruby shell (IRB) preloaded with your gem's code and dependencies. This allows you to experiment with the code and test API interactions.

To start the console, run:

```bash
bin/console
```

Once inside the console, you can use the `@client` object to interact with the API. For example, to list balances:

```ruby
balances = @client.balance.list(@today)
balances.each do |balance|
  puts balance.account
  puts balance.balance_in_money.format
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/merof-code/privat_bank_business_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/merof-code/privat_bank_business_api/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the PrivatBankBusinessApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/merof-code/privat_bank_business_api/blob/master/CODE_OF_CONDUCT.md).
