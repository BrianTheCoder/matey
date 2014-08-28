require "matey/client"

# requests
require 'matey/ups/address_validation_request'
require 'matey/ups/rate_request'
require 'matey/ups/shipment_request'
require 'matey/ups/tracking_info_request'

# responses
require 'matey/ups/address_validation_response'
require 'matey/ups/rate_response'
require 'matey/ups/shipment_response'
require 'matey/ups/tracking_info_response'

module Matey
  module Ups
    class Client < Matey::Client
      TEST_URL = 'https://wwwcie.ups.com'.freeze
      LIVE_URL = 'https://onlinetools.ups.com'.freeze

      attr_accessor :key, :login, :password

      validates :key, presence: true
      validates :login, presence: true
      validates :password, presence: true

      def initialize(credentials = {})
        @key = credentials[:key] || ENV['UPS_KEY']
        @login = credentials[:login] || ENV['UPS_LOGIN']
        @password = credentials[:password] || ENV['UPS_PASSWORD']
        super
      end
    end
  end
end