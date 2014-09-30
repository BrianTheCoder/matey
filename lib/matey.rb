$:.unshift File.dirname(__FILE__)

require 'dotenv'
Dotenv.load

require "matey/version"
require "active_support/core_ext"
require "virtus"

module Matey
  autoload :Client, "matey/client"
  autoload :Request, "matey/request"
  autoload :Response, "matey/response"

  # models
  autoload :Location, "matey/models/location"
  autoload :Package, "matey/models/package"
  autoload :Item, "matey/models/item"

  # clients
  module Fedex
    autoload :Client, "matey/carriers/fedex/client"
  end
end