# Require gem and standard helpers
require_relative '../test/helper'

# Require RSpec

require 'rspec'

RSpec.configure do |config|
  config.color = true
end

# Configure Bdd

Bdd.configure do |config|
  config.framework :rspec
  # NOTE: maybe this should go to tmp/ instead
  config.reporters yaml: 'examples/yml_rspec_report.yml'
  # English
  config.language %w[Given], %w[When Then], %w[And But]
  # Portuguese
  config.language %w[Dado], %w[Quando Entao], %w[E Mas]
end

# Minitest Helper Methods

def some_failed_expectation
  expect(1).to eql(2)
end

# Test Code

require_relative 'test_common'
