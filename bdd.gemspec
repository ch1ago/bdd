# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bdd/version'

Gem::Specification.new do |spec|
  spec.name          = "bdd"
  spec.version       = Bdd::VERSION
  spec.authors       = ["James Pinto"]
  spec.email         = ["thejamespinto@gmail.com"]

  spec.summary       =
  spec.description   = %q{Easily add User Stories to rspec and minitest}
  spec.homepage      = "https://github.com/thejamespinto/bdd"

  spec.license       = "MIT"
  # spec.required_ruby_version = Gem::Requirement.new(">= 2.4.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|examples|images|test)/}) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler' #, '~> 2.0'
  spec.add_development_dependency 'rake' #, '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'simplecov', '~> 0.17'
end
