require 'rspec'

module Bdd
  #
  # This procedural module encapsulates code from gem 'rspec'
  #
  # Learn more at: https://github.com/rspec/rspec
  module RspecFramework
    module_function

    module GroupMethods; end

    def name
      'RSpec'
    end

    def group_methods_module
      GroupMethods
    end

    def register!
      _register_group_methods
      _register_reports
    end

    def _register_group_methods
      group_class.send(:extend, group_methods_module)
    end

    # Resource: https://apidock.com/ruby/Kernel/at_exit
    def _register_reports
      Kernel.at_exit { Bdd.instance.run_reports! }
    end

    def group_class
      RSpec::Core::ExampleGroup
    end

    def current_example
      RSpec.current_example
    end

    def get_parent_groups(example)
      example.example_group.parent_groups
    end

    def get_title(example_or_group)
      example_or_group.metadata[:description]
    end

    # Resource: https://relishapp.com/rspec/rspec-core/v/3-8/docs/pending-and-skipped-examples/pending-examples
    def write(instance, example, keys, title, string, &block)
      data = instance.data
      if block_given?
        yield
        data.write(keys, :passed, title, string)
      else
        data.write(keys, :skipped, title, "#{string} (skipped)")
        example.instance_eval('@bdd_skipped = true')
        example.send(:skip)
        example.send(:fail)
      end
    rescue RSpec::Core::Pending::SkipDeclaredInExample
      data.write(keys, :skipped, title, "#{string} (skipped)")
      raise
    rescue RSpec::Expectations::ExpectationNotMetError
      data.write(keys, :failed, title, "#{string} (failed)")
      raise
    rescue => e
      unless example.instance_eval('@bdd_skipped')
        data.write(keys, :failed, title, "#{string} (#{e.class}) #{e.message}")
        # data.write(keys, :failed, title, string)
      end
      raise
    end
  end
end
