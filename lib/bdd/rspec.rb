require 'bdd/rspec/example_group'

RSpec::Core::ExampleGroup.send :include, Bdd::RSpec::ExampleGroup

RSpec::Core::ExampleGroup.send :extend, Bdd::RSpec::ExampleGroup::ClassMethods

