require "matey/client"

# requests
require 'matey/landmark/address_validation_request'
require 'matey/landmark/rate_request'
require 'matey/landmark/shipment_request'
require 'matey/landmark/tracking_info_request'

# responses
require 'matey/landmark/address_validation_response'
require 'matey/landmark/rate_response'
require 'matey/landmark/shipment_response'
require 'matey/landmark/tracking_info_response'

module Matey
  module Landmark
    class Client < Matey::Client
      TEST_URL = 'https://mercury.landmarkglobal.com/api/api.php'.freeze
      LIVE_URL = 'https://mercury.landmarkglobal.com/api/api.php'.freeze

      attr_accessor :key, :meter, :password, :account

      validates :username, presence: true
      validates :password, presence: true

      def initialize(credentials = {})
        @username = credentials[:username] || ENV['LANDMARK_USERNAME']
        @password = credentials[:password] || ENV['LANDMARK_PASSWORD']
        super
      end
    end
  end
end