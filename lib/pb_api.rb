# typed: true
# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "dry-types"
require "dry-struct"
require "dry-transformer"
require "money"

require_relative "pb_api/version"
require_relative "pb_api/types"
require_relative "pb_api/client"
require_relative "pb_api/resource"
require_relative "pb_api/base_transformer"
require_relative "pb_api/models/base_struct"

require_relative "pb_api/resources/balance_resource"
require_relative "pb_api/transformers/balance_transformer"
require_relative "pb_api/models/balance"

require_relative "pb_api/resources/transaction_resource"
require_relative "pb_api/transformers/transaction_transformer"
require_relative "pb_api/models/transaction"
require_relative "pb_api/pagination_helper"

# Main entry point for the gem, use client = PbAPI::Client.new(api_token: "token") to start using the API.
module PbAPI
  class Error < StandardError; end

  def self.logger
    @@logger ||= defined?(Rails) ? Rails.logger : Logger.new($stdout, progname: "PbApi") # rubocop:disable Style/ClassVars
  end
end
