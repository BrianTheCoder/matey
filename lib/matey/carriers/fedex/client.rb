module Matey
  module Fedex
    ServiceTypes = {
      "PRIORITY_OVERNIGHT" => "FedEx Priority Overnight",
      "PRIORITY_OVERNIGHT_SATURDAY_DELIVERY" => "FedEx Priority Overnight Saturday Delivery",
      "FEDEX_2_DAY" => "FedEx 2 Day",
      "FEDEX_2_DAY_SATURDAY_DELIVERY" => "FedEx 2 Day Saturday Delivery",
      "STANDARD_OVERNIGHT" => "FedEx Standard Overnight",
      "FIRST_OVERNIGHT" => "FedEx First Overnight",
      "FIRST_OVERNIGHT_SATURDAY_DELIVERY" => "FedEx First Overnight Saturday Delivery",
      "FEDEX_EXPRESS_SAVER" => "FedEx Express Saver",
      "FEDEX_1_DAY_FREIGHT" => "FedEx 1 Day Freight",
      "FEDEX_1_DAY_FREIGHT_SATURDAY_DELIVERY" => "FedEx 1 Day Freight Saturday Delivery",
      "FEDEX_2_DAY_FREIGHT" => "FedEx 2 Day Freight",
      "FEDEX_2_DAY_FREIGHT_SATURDAY_DELIVERY" => "FedEx 2 Day Freight Saturday Delivery",
      "FEDEX_3_DAY_FREIGHT" => "FedEx 3 Day Freight",
      "FEDEX_3_DAY_FREIGHT_SATURDAY_DELIVERY" => "FedEx 3 Day Freight Saturday Delivery",
      "INTERNATIONAL_PRIORITY" => "FedEx International Priority",
      "INTERNATIONAL_PRIORITY_SATURDAY_DELIVERY" => "FedEx International Priority Saturday Delivery",
      "INTERNATIONAL_ECONOMY" => "FedEx International Economy",
      "INTERNATIONAL_FIRST" => "FedEx International First",
      "INTERNATIONAL_PRIORITY_FREIGHT" => "FedEx International Priority Freight",
      "INTERNATIONAL_ECONOMY_FREIGHT" => "FedEx International Economy Freight",
      "GROUND_HOME_DELIVERY" => "FedEx Ground Home Delivery",
      "FEDEX_GROUND" => "FedEx Ground",
      "INTERNATIONAL_GROUND" => "FedEx International Ground",
      "SMART_POST" => "FedEx SmartPost",
      "FEDEX_FREIGHT_PRIORITY" => "FedEx Freight Priority",
      "FEDEX_FREIGHT_ECONOMY" => "FedEx Freight Economy"
    }

    PackageTypes = {
      "fedex_envelope" => "FEDEX_ENVELOPE",
      "fedex_pak" => "FEDEX_PAK",
      "fedex_box" => "FEDEX_BOX",
      "fedex_tube" => "FEDEX_TUBE",
      "fedex_10_kg_box" => "FEDEX_10KG_BOX",
      "fedex_25_kg_box" => "FEDEX_25KG_BOX",
      "your_packaging" => "YOUR_PACKAGING"
    }

    DropoffTypes = {
      'regular_pickup' => 'REGULAR_PICKUP',
      'request_courier' => 'REQUEST_COURIER',
      'dropbox' => 'DROP_BOX',
      'business_service_center' => 'BUSINESS_SERVICE_CENTER',
      'station' => 'STATION'
    }

    PaymentTypes = {
      'sender' => 'SENDER',
      'recipient' => 'RECIPIENT',
      'third_party' => 'THIRDPARTY',
      'collect' => 'COLLECT'
    }

    PackageIdentifierTypes = {
      'tracking_number' => 'TRACKING_NUMBER_OR_DOORTAG',
      'door_tag' => 'TRACKING_NUMBER_OR_DOORTAG',
      'rma' => 'RMA',
      'ground_shipment_id' => 'GROUND_SHIPMENT_ID',
      'ground_invoice_number' => 'GROUND_INVOICE_NUMBER',
      'ground_customer_reference' => 'GROUND_CUSTOMER_REFERENCE',
      'ground_po' => 'GROUND_PO',
      'express_reference' => 'EXPRESS_REFERENCE',
      'express_mps_master' => 'EXPRESS_MPS_MASTER'
    }

    TransitTimes = ["UNKNOWN","ONE_DAY","TWO_DAYS","THREE_DAYS","FOUR_DAYS","FIVE_DAYS","SIX_DAYS","SEVEN_DAYS","EIGHT_DAYS","NINE_DAYS","TEN_DAYS","ELEVEN_DAYS","TWELVE_DAYS","THIRTEEN_DAYS","FOURTEEN_DAYS","FIFTEEN_DAYS","SIXTEEN_DAYS","SEVENTEEN_DAYS","EIGHTEEN_DAYS"]

    # FedEx tracking codes as described in the FedEx Tracking Service WSDL Guide
    # All delays also have been marked as exceptions
    TRACKING_STATUS_CODES = HashWithIndifferentAccess.new({
      'AA' => :at_airport,
      'AD' => :at_delivery,
      'AF' => :at_fedex_facility,
      'AR' => :at_fedex_facility,
      'AP' => :at_pickup,
      'CA' => :canceled,
      'CH' => :location_changed,
      'DE' => :exception,
      'DL' => :delivered,
      'DP' => :departed_fedex_location,
      'DR' => :vehicle_furnished_not_used,
      'DS' => :vehicle_dispatched,
      'DY' => :exception,
      'EA' => :exception,
      'ED' => :enroute_to_delivery,
      'EO' => :enroute_to_origin_airport,
      'EP' => :enroute_to_pickup,
      'FD' => :at_fedex_destination,
      'HL' => :held_at_location,
      'IT' => :in_transit,
      'LO' => :left_origin,
      'OC' => :order_created,
      'OD' => :out_for_delivery,
      'PF' => :plane_in_flight,
      'PL' => :plane_landed,
      'PU' => :picked_up,
      'RS' => :return_to_shipper,
      'SE' => :exception,
      'SF' => :at_sort_facility,
      'SP' => :split_status,
      'TR' => :transfer
    })

    autoload :AddressValidationRequest, "matey/carriers/fedex/address_validation_request"
    autoload :AddressValidationResponse, "matey/carriers/fedex/address_validation_response"

    autoload :RateRequest, "matey/carriers/fedex/rate_request"
    autoload :RateResponse, "matey/carriers/fedex/rate_response"

    autoload :ShipmentRequest, "matey/carriers/fedex/shipment_request"
    autoload :ShipmentResponse, "matey/carriers/fedex/shipment_response"

    autoload :TrackingInfoRequest, "matey/carriers/fedex/tracking_info_request"
    autoload :TrackingInfoResponse, "matey/carriers/fedex/tracking_info_response"

    class Client < Matey::Client
      TEST_URL = 'https://gatewaybeta.fedex.com/xml'.freeze
      LIVE_URL = 'https://gateway.fedex.com/xml'.freeze

      attribute :key, String
      attribute :meter, Fixnum
      attribute :password, String
      attribute :account, Fixnum

      validates :key, presence: true
      validates :meter, presence: true, numericality: true
      validates :password, presence: true
      validates :account, presence: true, numericality: true

      def initialize(credentials = {})
        @key = credentials[:key] || ENV['FEDEX_KEY']
        @meter = credentials[:meter] || ENV['FEDEX_METER']
        @password = credentials[:password] || ENV['FEDEX_PASSWORD']
        @account = credentials[:account] || ENV['FEDEX_ACCOUNT']
        super
      end

      def rates(origin, destination, packages, options = {})
        self.last_request = RateRequest.new(origin, destination, packages)
        send_request(nil, RateResponse)
      end

      def tracking_info(tracking_number, options={})
        self.last_request = TrackingInfoRequest.new(tracking_number)
        send_request(nil, TrackingInfoResponse)
      end

      def create_shipment(origin, destination, package, options = {})
        self.last_request = ShipmentRequest.new(origin, destination, package)
        send_request(nil, ShipmentResponse)
      end

      def validate_address(location, options = {})
        self.last_request = AddressValidationRequest.new(location)
        send_request(nil, AddressValidationResponse)
      end

      protected

      def client
        @_client ||= Faraday.new (@test ? TEST_URL : LIVE_URL) do |conn|
          conn.response :xml, content_type: /\bxml$/
          conn.use :instrumentation
          conn.adapter Faraday.default_adapter
        end
      end
    end
  end
end