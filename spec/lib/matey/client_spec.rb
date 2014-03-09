require 'spec_helper'

describe Matey::Client do
  let(:carrier){ Matey::Client.new }

  it 'responds to rates' do
    carrier.should respond_to(:rates)
  end

  it 'responds to tracking_info' do
    carrier.should respond_to(:tracking_info)
  end

    it 'responds to create_shipment' do
    carrier.should respond_to(:create_shipment)
  end

    it 'responds to validate_address' do
    carrier.should respond_to(:validate_address)
  end
end