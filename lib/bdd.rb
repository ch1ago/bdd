module Bdd
  autoload :Adapters, 'bdd/adapters'
  autoload :Colors, 'bdd/colors'
  autoload :StringBuilder, 'bdd/string_builder'
  autoload :Title, 'bdd/title'
end

require "bdd/version"
require "bdd/class_methods"

if defined?(::RSpec::Core) && !defined?(Bdd::RSpec)
  require 'bdd/rspec'
end

if defined?(::Minitest::Reporter) && !defined?(Bdd::Minitest)
  require 'bdd/minitest'
end
