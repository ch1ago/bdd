require 'minitest'
require 'minitest/reporters'
require 'minitest/spec' # I don't understand why this does not load automatically

module Bdd
  module Minitest
    Reporter = Class.new(::Minitest::Reporters::SpecReporter)
  end
end

require 'bdd' # must load after Bdd::Minitest

Bdd::Adapters::MinitestAdapter.register
