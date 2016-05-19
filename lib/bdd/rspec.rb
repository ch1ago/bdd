# require "rspec/core"

require 'bdd/rspec/example_group'

RSpec::Core::ExampleGroup.send :include, Bdd::RSpec::ExampleGroup
