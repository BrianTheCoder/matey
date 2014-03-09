module Matey
  class Location
    attr_accessor :name,
                  :address1,
                  :address2,
                  :city,
                  :state,
                  :postal_code,
                  :country,
                  :phone,
                  :fax,
                  :type

    alias_method :zip, :postal_code
    alias_method :postal, :postal_code
    alias_method :province, :state
    alias_method :territory, :province
    alias_method :region, :province

    def initialize(attributes = {})
      @country = attributes[:country]
      @postal_code = attributes[:postal_code] || attributes[:postal] || attributes[:zip]
      @province = attributes[:province] || attributes[:state] || attributes[:territory] || attributes[:region]
      @city = attributes[:city]
      @name = attributes[:name]
      @address1 = attributes[:address1]
      @address2 = attributes[:address2]
      @phone = attributes[:phone]
      @fax = attributes[:fax]
    end
  end
end