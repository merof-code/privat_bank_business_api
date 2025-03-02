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
require_relative "pb_api/pagination_helper"


module PbAPI
  class Error < StandardError; end

  def self.logger
    @@logger ||= begin
      base_logger = defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
      base_logger.formatter = proc do |severity, datetime, progname, msg|
        formatted_time = datetime.strftime("%Y-%m-%dT%H:%M:%S.%6N")
        "#{severity[0]}, [#{formatted_time} ##{Process.pid} PbAPI]  #{severity} -- #{msg}\n"
      end
      base_logger
    end
  end
end
