require "yaml"

describe Matey::Fedex::Client do
  let(:client){ Matey::Fedex::Client.new }
  let(:locations){ YAML.load_file('spec/fixtures/locations.yml')}

  it 'validates the client' do
    client.should be_valid
  end

  context '#validate_address' do
    it 'validates an address' do
      location =  Matey::Location.new(locations[:beverly_hills])
      resp = client.validate_address(location)
      expect(resp.success?).to eq(true)
      expect(resp.score).to eq(88)
    end
  end

  context '#create_shipment' do
    it 'creates a shipment' do
      origin =  Matey::Location.new(locations[:beverly_hills])
      destination =  Matey::Location.new(locations[:real_home_as_residential])
      resp = client.create_shipment(origin, destination)
    end
  end

  context '#rates' do
    it 'fetches rate info' do
      origin =  Matey::Location.new(locations[:beverly_hills])
      destination =  Matey::Location.new(locations[:real_home_as_residential])
      resp = client.create_shipment(origin, destination)
    end
  end

  context '#tracking_info' do
    it "finds tracking info should return a tracking response" do
      assert_instance_of ActiveMerchant::Shipping::TrackingResponse, @carrier.find_tracking_info('077973360403984', :test => true)
    end

    it "finds tracking info should mark shipment as delivered" do
      assert_equal true, @carrier.find_tracking_info('077973360403984').delivered?
    end

    it "finds tracking info should return correct carrier" do
      assert_equal :fedex, @carrier.find_tracking_info('077973360403984').carrier
    end

    it "finds tracking info should return correct carrier name" do
      assert_equal 'FedEx', @carrier.find_tracking_info('077973360403984').carrier_name
    end

    it "finds tracking info should return correct status" do
      assert_equal :delivered, @carrier.find_tracking_info('077973360403984').status
    end

    it "finds tracking info should return correct status code" do
      assert_equal 'dl', @carrier.find_tracking_info('077973360403984').status_code.downcase
    end

    it "finds tracking info should return correct status description" do
      assert_equal 'delivered', @carrier.find_tracking_info('1Z5FX0076803466397').status_description.downcase
    end

    it "finds tracking info should return delivery signature" do
      assert_equal 'KKING', @carrier.find_tracking_info('077973360403984').delivery_signature
    end

    it "finds tracking info should return destination address" do
      result = @carrier.find_tracking_info('077973360403984')
      assert_equal 'sacramento', result.destination.city.downcase
      assert_equal 'CA', result.destination.state
    end

    it "finds tracking info should gracefully handle missing destination information" do
      result = @carrier.find_tracking_info('077973360403984')
      assert_equal 'unknown', result.destination.city.downcase
      assert_equal 'unknown', result.destination.state
      assert_equal 'ZZ', result.destination.country.code(:alpha2).to_s
    end

    it "finds tracking info should return correct shipper address" do
      response = @carrier.find_tracking_info('927489999894450502838')
      assert_equal 'wallingford', response.shipper_address.city.downcase
      assert_equal 'CT', response.shipper_address.state
    end

    it "finds tracking info should gracefully handle missing shipper address" do
      response = @carrier.find_tracking_info('077973360403984')
      assert_equal nil, response.shipper_address
    end

    it "finds tracking info should return correct ship time" do
      response = @carrier.find_tracking_info('927489999894450502838')
      assert_equal Time.parse("2008-12-03T00:00:00").utc, response.ship_time
    end

    it "finds tracking info should gracefully handle missing ship time" do
      response = @carrier.find_tracking_info('927489999894450502838')
      assert_equal nil, response.ship_time
    end

    it "finds tracking info should return correct actual delivery date" do
      response = @carrier.find_tracking_info('077973360403984')
      assert_equal Time.parse('2008-12-08T07:43:37-08:00').utc, response.actual_delivery_date
    end

    it "finds tracking info should gracefully handle missing actual delivery date" do
      # This particular fixture doesn't contain an actual delivery date
      # (in addition to having a shipper address)
      response = @carrier.find_tracking_info('9274899998944505028386')
      assert_equal nil, response.actual_delivery_date
    end

    it "finds tracking info should return correct scheduled delivery date" do
      response = @carrier.find_tracking_info('1234567890111')
      assert_equal Time.parse('2013-10-15T00:00:00').utc, response.scheduled_delivery_date
    end

    it "finds tracking info should gracefully handle missing scheduled delivery date" do
      response = @carrier.find_tracking_info('077973360403984')
      assert_equal nil, response.scheduled_delivery_date
    end

    it "finds tracking info should return origin address" do
      result = @carrier.find_tracking_info('077973360403984')
      assert_equal 'nashville', result.origin.city.downcase
      assert_equal 'TN', result.origin.state
    end

    it "finds tracking info should parse response into correct number of shipment events" do
      response = @carrier.find_tracking_info('077973360403984')
      assert_equal 6, response.shipment_events.size
    end

    it "finds tracking info should return shipment events in ascending chronological order" do
      response = @carrier.find_tracking_info('077973360403984')
      assert_equal response.shipment_events.map(&:time).sort, response.shipment_events.map(&:time)
    end

    it "finds tracking info should not include events without an address" do
      response = @carrier.find_tracking_info('077973360403984')
      assert_nil response.shipment_events.find{|event| event.name == 'Shipment information sent to FedEx' }
    end
  end
end