module Matey
  class RateRequest < Matey::Request
    attr_accessor :origin, :destination, :packages

    def initialize(origin, destination, packages = [])
      self.origin = origin
      self.destination = destination
      self.packages = packages
    end
  end
end