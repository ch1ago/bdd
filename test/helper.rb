path = File.expand_path('../lib', __dir__)
# puts path
$LOAD_PATH.unshift path

require 'simplecov'

SimpleCov.start do
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
    'test/frameworks',
    # 'lib/bdd/frameworks',
    # 'test/bdd/frameworks',
    # 'test_frameworks'
  ]
  add_filter 'lib/bdd/frameworks'
  add_filter 'test/bdd/frameworks'
  add_filter 'test_frameworks'

  add_group 'Reports', [
    'lib/bdd/reports',
    'test/bdd/reports'
  ]

  add_group 'Utils', [
    'lib/bdd/utils',
    'test/bdd/utils'
  ]
end

require 'bdd'
