module Matey
  class Package
    include Virtus.model
    include ActiveModel::Validations

    attribute :address, Matey::Location
    attribute :width, Float, default: 12
    attribute :height, Float, default: 12
    attribute :length, Float, default: 12
    attribute :weight, Float, default: 1
    attribute :imperial, Boolean, default: true
    attribute :value, Float, default: 0
    attribute :currency, String, default: 'USD'
  end
end