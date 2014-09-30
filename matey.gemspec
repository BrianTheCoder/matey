# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matey/version'

Gem::Specification.new do |spec|
  spec.name          = "matey"
  spec.version       = Matey::VERSION
  spec.authors       = ["brianthecoder"]
  spec.email         = ["brian@dstld.la"]
  spec.summary       = %q{Provides a common abstraction to working with shipping apis}
  spec.description   = %q{Provides a common abstraction to working with shipping apis. (rates, tracking info, address validtion and shipping management)}
  spec.homepage      = ""
  spec.license       = "MIT"

  # spec.files         = `git ls-files -z`.split("\x0")
  spec.files        = Dir.glob("lib/**/*")
  spec.require_path = 'lib'

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(spec)/})

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"
  spec.add_dependency "dotenv"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "multi_xml"
  spec.add_dependency "nokogiri"
  spec.add_dependency "slim"
  spec.add_dependency "tilt"
  spec.add_dependency "virtus"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
end
