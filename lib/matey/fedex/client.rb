require "matey/client"

# requests
require 'matey/fedex/address_validation_request'
require 'matey/fedex/rate_request'
require 'matey/fedex/shipment_request'
require 'matey/fedex/tracking_info_request'

# responses
require 'matey/fedex/address_validation_response'
require 'matey/fedex/rate_response'
require 'matey/fedex/shipment_response'
require 'matey/fedex/tracking_info_response'

module Matey
  module Fedex
    class Client < Matey::Client
      attr_accessor :key, :meter, :password, :account

      validates :key, presence: true
      validates :meter, presence: true, numericality: true
      validates :password, presence: true
      validates :account, presence: true, numericality: true

      def initialize(credentials = {})
        @key = credentials[:key] || ENV['FEDEX_KEY']
        @meter = credentials[:meter] || ENV['FEDEX_METER']
        @password = credentials[:password] || ENV['FEDEX_PASSWORD']
        @account = credentials[:account] || ENV['FEDEX_ACCOUNT']
        super
      end
    end
  end
end