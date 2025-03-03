module PbAPI
  class Client
    BASE_URL = "https://acp.privatbank.ua/api/"
    attr_reader :api_token, :adapter

    def initialize(api_token:, adapter: Faraday.default_adapter, stubs: nil)
      @api_token = api_token
      @adapter = adapter

      # Test stubs for requests
      @stubs = stubs
    end

    def connection
      @connection ||= Faraday.new(BASE_URL) do |b|
        b.headers["token"] = @api_token
        b.headers["Content-Type"] = "application/json;charset=utf8"
        b.ssl.verify = true
        b.response :json
        b.response :logger, PbAPI.logger, { headers: false, bodies: false }
      end
    end

    # Returns a new instance of PbAPI::Resources::BalanceResource for handling balance-related API operations.
    # @return [PbAPI::Resources::BalanceResource] The balance resource client.
    def balances
      PbAPI::Resources::BalanceResource.new(self)
    end

    # Returns a new instance of PbAPI::Resources::TransactionResource for handling transaction-related API operations.
    # @return [PbAPI::Resources::TransactionResource] The transaction resource client.
    def transactions
      PbAPI::Resources::TransactionResource.new(self)
    end
  end
end
