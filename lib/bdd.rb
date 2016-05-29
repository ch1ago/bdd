module Bdd
  autoload :Adapters, 'bdd/adapters'
  autoload :Colors, 'bdd/colors'
  autoload :StringBuilder, 'bdd/string_builder'
  autoload :Title, 'bdd/title'
  autoload :Check, 'bdd/check'
end

require "bdd/version"
require "bdd/class_methods"

Bdd::Check.new
