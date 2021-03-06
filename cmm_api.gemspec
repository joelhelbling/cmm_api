# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cmm_api/version'

Gem::Specification.new do |spec|
  spec.name          = "cmm_api"
  spec.version       = CmmApi::VERSION
  spec.authors       = ["Joel Helbling"]
  spec.email         = ["joel@joelhelbling.com"]
  spec.summary       = %q{Simple client to the CoverMyMeds API.}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "its"
  spec.add_development_dependency "pry"
end
