module Bdd
  autoload :Adapters, 'bdd/adapters'
  autoload :Colors, 'bdd/colors'
  autoload :StringBuilder, 'bdd/string_builder'
  autoload :Title, 'bdd/title'
end

require "bdd/version"
require "bdd/class_methods"

if defined?(::RSpec) && !defined?(Bdd::RSpec)
  require 'bdd/rspec'
end

if defined?(::Minitest) && !defined?(Bdd::Minitest)
  require 'bdd/minitest'
end
