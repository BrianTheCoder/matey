require 'nokogiri'

module Matey
  class Response
    attr_accessor :response

    def initialize(response)
      @response = response
    end
  end
end