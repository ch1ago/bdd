# this file helper.rb is used from examples/*.rb
path = File.expand_path('../lib', __dir__)
# puts path
$LOAD_PATH.unshift path

require 'simplecov'

SimpleCov.start do
  add_filter 'lib/bdd/version.rb'

  add_group 'Core', [
    'lib/bdd.rb',
    'lib/bdd/core',
    'test/bdd/core'
  ]

  add_group 'Adapters', [
    'lib/bdd/adapters',
    'test/bdd/adapters'
  ]

  # TODO: find how to add these files to coverage
  # (they are run by different processes)
  # Resource: https://github.com/simplecov-ruby/simplecov

  add_group 'Frameworks', [
    'test/examples',
    # 'lib/bdd/frameworks',
    # 'test/bdd/frameworks',
    # 'examples'
  ]
  add_filter 'lib/bdd/frameworks'
  add_filter 'test/bdd/frameworks'
  add_filter 'examples'

  add_group 'Reporters', [
    'lib/bdd/reporters',
    'test/bdd/reporters'
  ]

  add_group 'Utils', [
    'lib/bdd/utils',
    'test/bdd/utils'
  ]
end

require 'bdd'
require 'yaml'

# Ruby <= 2.1
unless "".respond_to?(:match?)
  class String
    def match?(*args)
      !!match(*args)
    end
  end
end
