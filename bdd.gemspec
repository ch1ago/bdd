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
  spec.description   = %q{Cucumber style in your RSpec/Minitest tests}
  spec.homepage      = "https://github.com/thejamespinto/bdd"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(images|test|spec|test_frameworks)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'minitest', '~> 5.14'
  spec.add_development_dependency 'simplecov', '~> 0.18'
end
