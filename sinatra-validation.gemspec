# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/validation/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-validation"
  spec.version       = Sinatra::Validation::VERSION
  spec.authors       = ["IzumiSy"]
  spec.email         = ["beetle-noise@gmx.com"]

  spec.summary       = %q{ "Sinatra extension for request parameter validation" }
  spec.description   = %q{ "sinatra-validation is a gem to define parameter validation with dry-validation"}
  spec.homepage      = "https://github.com/IzumiSy/sinatra-validation"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '~> 2.0.7'
  spec.add_dependency 'rack', '>= 2.0.6'
  spec.add_dependency 'dry-validation', '~> 1.3'

  spec.add_development_dependency "bundler", "~> 2.0.2"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rack-test"
end
