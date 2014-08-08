# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rackspace/version'

Gem::Specification.new do |spec|
  spec.name          = "rackspace-api"
  spec.version       = Rackspace::VERSION
  spec.authors       = ["William Makley"]
  spec.email         = ["wmakley@tortus.com"]
  spec.summary       = %q{Library to simplify interacting with the Rackspace JSON API.}
  spec.description   = %q{Simple front-end for JSON api.}
  spec.homepage      = "http://www.tortus.com/"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "json", "~> 1.7"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.3"
end
