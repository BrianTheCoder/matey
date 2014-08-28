require "matey/client"

# requests
require 'matey/dhl/address_validation_request'
require 'matey/dhl/rate_request'
require 'matey/dhl/shipment_request'
require 'matey/dhl/tracking_info_request'

# responses
require 'matey/dhl/address_validation_response'
require 'matey/dhl/rate_response'
require 'matey/dhl/shipment_response'
require 'matey/dhl/tracking_info_response'

module Matey
  module Dhl
    class Client < Matey::Client
      TEST_URL = 'http://xmlpitest-ea.dhl.com/XMLShippingServlet'.freeze
      LIVE_URL = 'https://xmlpi-ea.dhl.com/XMLShippingServlet'.freeze

      attr_accessor :site_id, :password

      validates :site_id, presence: true
      validates :password, presence: true

      def initialize(credentials = {})
        @site_id = credentials[:site_id] || ENV['DHL_SITE_ID']
        @password = credentials[:password] || ENV['DHL_PASSWORD']
        super
      end
    end
  end
end