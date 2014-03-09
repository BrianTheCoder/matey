require "spec_helper"
require "matey/fedex/client"
require 'pry'

describe Matey::Fedex::Client do
  let(:client){ Matey::Fedex::Client.new }

  it 'validates the client' do
    client.should be_valid
  end
end