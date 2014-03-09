# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'matey/version'

Gem::Specification.new do |spec|
  spec.name          = "matey"
  spec.version       = Matey::VERSION
  spec.authors       = ["brianthecoder"]
  spec.email         = ["brian@20jeans.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  # spec.files         = `git ls-files -z`.split("\x0")
  spec.files        = Dir.glob("lib/**/*")
  spec.require_path = 'lib'

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})

  spec.add_dependency "activemodel"
  spec.add_dependency "activesupport"
  spec.add_dependency "dotenv"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "nokogiri"
  spec.add_dependency "slim"
  spec.add_dependency "tilt"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "vcr"
end
