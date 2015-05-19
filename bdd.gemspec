# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bdd/version'

Gem::Specification.new do |spec|
  spec.name          = "bdd"
  spec.version       = Bdd::VERSION
  spec.authors       = ["James Pinto"]
  spec.email         = ["thejamespinto@gmail.com"]

  spec.summary       = %q{Cucumber style in your RSpec tests}
  spec.description   = %q{Cucumber style in your RSpec tests}
  spec.homepage      = "https://github.com/thejamespinto/bdd"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  # end
  
  spec.add_runtime_dependency 'rspec'
  spec.add_runtime_dependency 'colorize'


  # spec.add_development_dependency "bundler", "~> 1.9"
  # spec.add_development_dependency "rake", "~> 10.0"
  # spec.add_development_dependency 'rspec'
end
