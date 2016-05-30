# gems like rspec-rails include 'rspec-core' but not 'rspec'
defined? RSpec or require 'rspec'

module Bdd
  module RSpec
    Formatter = Class.new(::RSpec::Core::Formatters::DocumentationFormatter)
  end
end

require 'bdd' # must load after Bdd::RSpec

Bdd::Adapters::RSpecAdapter.register
