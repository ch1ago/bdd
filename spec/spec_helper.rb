$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'bdd/rspec'

RSpec.configure do |config|
  config.color = true
  config.default_formatter = Bdd::RSpec::Formatter
end
