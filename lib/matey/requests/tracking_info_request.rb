module Matey
  class TrackingInfoRequest < Matey::Request
    attr_accessor :tracking_number

    def initialize(tracking_number)
      self.tracking_number = tracking_number
    end
  end
end