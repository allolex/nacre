# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "nacre/version"

Gem::Specification.new do |spec|
  spec.name          = "nacre"
  spec.version       = Nacre::VERSION
  spec.authors       = ["Damon Davison"]
  spec.email         = ["damon@curatur.com"]
  spec.summary       = %q{Nacre is a Ruby wrapper around the Brightpearl API}
  spec.description   = %q{Nacre provides access to the Brightpearl accounting/business management API. It hides away many of the complexities you may encounter when using the API.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "awesome_print"
end
