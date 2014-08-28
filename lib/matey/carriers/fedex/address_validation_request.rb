module Matey
  module Fedex
    class AddressValidationRequest < Matey::Requests::AddressValidationRequest
      DEFAULTS = {
        street_accuracy: :tight,
        directional_accuracy: :tight,
        company_name_accuracy: :loose,
        convert_to_upper_case: false,
        recognize_alternate_city_names: true,
        return_parsed_elements: true,
        maximum_number_of_matches: 1
      }
    end
  end
end