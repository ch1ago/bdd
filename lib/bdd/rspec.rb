require 'bdd/rspec/reporter'
require 'bdd/rspec/example_group'
require 'bdd/rspec/documentation_formatter'

RSpec::Core::Reporter.send     :include, Bdd::RSpec::Reporter
RSpec::Core::ExampleGroup.send :include, Bdd::RSpec::ExampleGroup



#
# CONFIGURE
#
RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end



#
# REGISTER
#

# if formatter = RSpec.world.reporter.__bdd_find_registered_formatter(RSpec::Core::Formatters::DocumentationFormatter)
#   RSpec.world.reporter.register_listener formatter, :example_started
#   RSpec::Core::Formatters.register       formatter
# end

formatter = RSpec::Core::Formatters::DocumentationFormatter.new($stdout)
RSpec.world.reporter.register_listener formatter, :example_started
RSpec::Core::Formatters.register       formatter
