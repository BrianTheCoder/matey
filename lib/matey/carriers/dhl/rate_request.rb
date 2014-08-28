module Matey
  module Dhl
    class RateRequest < Matey::Requests::RateRequest
      def imperial?
        ['US','LR','MM'].include?(origin.country_code(:alpha2))
      end
    end
  end
end