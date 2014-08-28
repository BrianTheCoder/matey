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
end