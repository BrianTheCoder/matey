require "matey/client"

# requests
require 'matey/on_trac/address_validation_request'
require 'matey/on_trac/rate_request'
require 'matey/on_trac/shipment_request'
require 'matey/on_trac/tracking_info_request'

# responses
require 'matey/on_trac/address_validation_response'
require 'matey/on_trac/rate_response'
require 'matey/on_trac/shipment_response'
require 'matey/on_trac/tracking_info_response'

module Matey
  module OnTrac
    class Client < Matey::Client
      TEST_URL = 'https://www.shipontrac.net/OnTracTestWebServices/OnTracServices.svc'.freeze
      LIVE_URL = 'https://www.shipontrac.net/OnTracWebServices/OnTracServices.svc'.freeze

      attr_accessor :account, :password

      validates :account, presence: true
      validates :password, presence: true

      def initialize(credentials = {})
        @account = credentials[:account] || ENV['ON_TRAC_ACCOUNT']
        @password = credentials[:password] || ENV['ON_TRAC_PASSWORD']
        super
      end
    end
  end
end