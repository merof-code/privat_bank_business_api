# typed: true

module PbAPI
  class Resource
    DATE_FORMAT_STRING = "%d-%m-%Y"
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def form_query(start_date, account = nil, end_date = nil, next_page_id = nil, results_per_page = 20)
      params_hash = {}
      params_hash[:startDate] ||= start_date.strftime(DATE_FORMAT_STRING)
      params_hash[:endDate] ||= end_date.strftime(DATE_FORMAT_STRING) unless end_date.nil?
      params_hash[:account] ||= account
      params_hash[:followId] ||= next_page_id
      params_hash[:limit] ||= results_per_page
      params_hash
    end

    private

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, body, headers)
    end

    def patch_request(url, body:, headers: {})
      handle_response client.connection.patch(url, body, headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, body, headers)
    end

    def delete_request(url, params: {}, headers: {})
      handle_response client.connection.delete(url, params, headers)
    end

    def handle_response(response)
      case response.status
      when 400
        raise Error, "Your request was malformed. #{response.body["message"]}"
      when 401
        raise Error, "You did not supply valid authentication credentials. #{response.body["message"]}"
      when 403
        raise Error, "You are not allowed to perform that action. #{response.body["message"]}"
      when 404
        raise Error, "No results were found for your request. #{response.body["message"]}"
      when 429
        raise Error, "Your request exceeded the API rate limit. #{response.body["message"]}"
      when 500
        raise Error, "We were unable to perform the request due to server-side problems. #{response.body["message"]}"
      when 503
        raise Error,
              "You have been rate limited for sending more than 20 requests per second. #{response.body["message"]}"
      end

      response
    end
  end
end
