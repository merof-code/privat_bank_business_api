# typed: true

module PbAPI::Resources
  class BalanceResource < PbAPI::Resource
    def common(uri, key, start_date, account, end_date, next_page_id, results_per_page)
      options = form_query(start_date, account, end_date, next_page_id, results_per_page)
      raw_data = get_request(uri, params: options).body["balances"]
      # raw_data is expected to be an array of hashes

      transformer = PbAPI::Transformers::BalanceTransformer.new
      transformed = transformer.call(raw_data)
      binding.irb
      # Create an array of Balance models from the transformed hashes
      transformed.map do |balance_hash|
        PbAPI::Models::Balance.new(balance_hash)
      end
    end

    # Get balance(s)
    # start_date required
    # account(iban string) and end_date optional
    def list(start_date, account = nil, end_date = nil, next_page_id = nil, results_per_page = 20)
      common("statements/balance", "balances", start_date, account, end_date, next_page_id, results_per_page)
    end

    # returns balances in interval
    def list_interim(account = nil, next_page_id = nil, results_per_page = 20)
      common("statements/balance/interim", "balances", start_date, account, end_date, next_page_id,
             results_per_page)
    end

    # account = string iban, optional
    def list_final(account = nil, next_page_id = nil, results_per_page = 20)
      common("statements/balance/final", "balances", start_date, account, end_date, next_page_id, results_per_page)
    end
  end
end
