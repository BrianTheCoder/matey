require "spec_helper"
require "matey/fedex/client"
require "pry"
require "yaml"

describe Matey::Fedex::AddressValidationRequest do
  let(:client){ Matey::Fedex::Client.new }
  let(:locations){ YAML.load_file('spec/fixtures/locations.yml')}

  it 'renders the request' do
    location =  Matey::Location.new(locations[:beverly_hills])
    request = Matey::Fedex::AddressValidationRequest.new(location)
    request.client = client
    puts request.render
  end
end