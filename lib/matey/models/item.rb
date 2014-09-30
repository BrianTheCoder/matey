module Matey
  class Item
    include Virtus.model
    include ActiveModel::Validations

    attribute :sku, String
    attribute :quantity, String
    attribute :weight, Float
  end
end