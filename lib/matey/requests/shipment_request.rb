module Matey
  module Requests
    class ShipmentRequest < Matey::Request
      attr_accessor :origin, :destination, :package

      def initialize(origin, destination, package)
        self.origin = origin
        self.destination = destination
        self.package = package
      end
    end
  end
end