module Matey
  class Location
    include Virtus.model
    include ActiveModel::Validations

    attribute :name, String
    attribute :address1, String
    attribute :address2, String
    attribute :city, String
    attribute :state, String
    attribute :postal_code, String
    attribute :country, String
    attribute :phone, String
    attribute :type, String

    alias_method :zip, :postal_code
    alias_method :postal, :postal_code
    alias_method :province, :state
    alias_method :territory, :province
    alias_method :region, :province

    validates :address1, presence: true
    validates :postal_code, presence: true
  end
end