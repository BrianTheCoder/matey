require 'active_model'
require 'faraday_middleware'

module Matey
  class Client
    include Virtus.model
    include ActiveModel::Validations

    attribute :test, Boolean
    attribute :last_request, Matey::Request
    attribute :last_response, Matey::Response

    def initialize(configuration = {})
      @test = configuration[:test] || ENV['TEST_MODE'] || false
    end

    protected

    def send_request(url, response_class)
      return last_request.errors unless last_request.valid?
      self.last_request.client = self
      self.last_response = client.post(url, last_request.render)
      response_class.new(self.last_response)
    end
  end
end