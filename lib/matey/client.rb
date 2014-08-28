require 'active_model'

# requests
require 'matey/requests/address_validation_request'
require 'matey/requests/rate_request'
require 'matey/requests/shipment_request'
require 'matey/requests/tracking_info_request'

# responses
require 'matey/responses/address_validation_response'
require 'matey/responses/rate_response'
require 'matey/responses/shipment_response'
require 'matey/responses/tracking_info_response'

module Matey
  class Client
    include ActiveModel::Validations

    attr_accessor :test, :last_requests, :last_response

    def initialize(configuration = {})
      @test = configuration[:test] || ENV['TEST_MODE'] || false
    end

    def rates(origin, destination, packages, options = {})
      self.last_request = RateRequest.new(origin, destination, packages)
      send_request(nil, RateResponse)
    end

    def tracking_info(tracking_number, options={})
      self.last_request = TrackingInfoRequest.new(tracking_number)
      send_request(nil, TrackingInfoResponse)
    end

    def create_shipment(origin, destination, package, options = {})
      self.last_request = ShipmentRequest.new(origin, destination, package)
      send_request(nil, ShipmentResponse)
    end

    def validate_address(location, options = {})
      self.last_request = AddressValidationRequest.new(location)
      send_request(nil, AddressValidationResponse)
    end

    protected

    def send_request(url, response_class)
      return last_request.errors unless last_request.valid?
      self.last_response = client.post(url, last_request.render(options))
      response_class.new(self.last_response)
    end

    def client
      @_client ||= Faraday.new (@test ? TEST_URL : LIVE_URL) do |conn|
        conn.response :xml, content_type: /\bxml$/
        conn.use :instrumentation
        conn.adapter Faraday.default_adapter
      end
    end
  end
end