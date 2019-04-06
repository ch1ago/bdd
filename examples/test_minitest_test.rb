# Require gem and standard helpers
require_relative '../test/helper'

# Require Minitest

require 'minitest/autorun'

# Configure Bdd

Bdd.configure do |config|
  config.framework :minitest
  # NOTE: maybe this should go to tmp/ instead
  config.reporters yaml: 'examples/yml_minitest_report.yml'
  # English
  config.language %w[Given], %w[When Then], %w[And But]
  # Portuguese
  config.language %w[Dado], %w[Quando Entao], %w[E Mas]
end

# Minitest Helper Methods

def some_failed_expectation
  assert_equal(1, 2)
end

# Test Code

require_relative 'test_common'
