$:.unshift File.dirname(__FILE__)
$:.unshift File.dirname("#{__FILE__}/../views")

require 'dotenv'
Dotenv.load

require "matey/version"
require "active_support/core_ext"
require "active_support/core_ext/object/to_json"

module Matey
  # Your code goes here...
  autoload :Client, "matey/client"
  autoload :Request, "matey/request"
  autoload :Response, "matey/response"
  autoload :Location, "matey/location"
end
