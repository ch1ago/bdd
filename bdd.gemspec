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
  spec.description   = %q{Cucumber style in your RSpec tests}
  spec.homepage      = "https://github.com/thejamespinto/bdd"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'minitest'
  spec.add_development_dependency 'minitest-reporters', '1.1.9'
end
