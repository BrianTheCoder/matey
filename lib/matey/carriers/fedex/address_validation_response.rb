require "matey/responses/address_validation_response"

module Matey
  module Fedex
    class AddressValidationResponse < Matey::AddressValidationResponse
      def success?
        response.body['AddressValidationReply']['HighestSeverity'] == 'SUCCESS'
      end

      def score
        address_details['Score'].to_i
      end

      def suggestion
        {
          address1: address_details['Address']['StreetLines'].titleize,
          city: address_details['Address']['City'].titleize,
          state: address_details['Address']['StateOrProvinceCode'].titleize,
          postal_code: address_details['Address']['PostalCode'].titleize,
          country: address_details['Address']['CountryCode']
        }
      end

      # protected

      def address_details
        response.body['AddressValidationReply']['AddressResults']['ProposedAddressDetails']
      end
    end
  end
end