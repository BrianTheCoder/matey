module Matey
  module Requests
    class AddressValidationRequest < Matey::Request
      attr_accessor :location

      validates :location, presence: true

      def initialize(location)
        self.location = location
      end
    end
  end
end