# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'apitools/middleware/version'

Gem::Specification.new do |spec|
  spec.name          = "apitools-middleware"
  spec.version       = Apitools::Middleware::VERSION
  spec.authors       = ["Michal Cichra"]
  spec.email         = ["michal@3scale.net"]
  spec.summary       = %q{Ruby Libary for Apitools Middleware}
  spec.description   = %q{Apitools Middleware manifest, repository, specification and more.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_development_dependency 'rspec', '~> 3.0.0'

  spec.add_dependency 'semantic'
end
