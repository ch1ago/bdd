module Bdd
  module Adapters
    autoload :Base,            'bdd/adapters/base'
    autoload :RSpecAdapter,    'bdd/adapters/rspec_adapter'
    autoload :MinitestAdapter, 'bdd/adapters/minitest_adapter'
  end
end
