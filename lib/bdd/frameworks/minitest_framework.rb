require 'minitest'

module Bdd
  #
  # This procedural module encapsulates code from gem 'minitest'
  #
  # Learn more at: https://github.com/seattlerb/minitest
  module MinitestFramework
    module_function

    module GroupMethods; end

    def name
      'Minitest'
    end

    def group_methods_module
      GroupMethods
    end

    def register!
      _register_group_methods
      _register_reports
    end

    def _register_group_methods
      group_class.send :extend, group_methods_module
    end

    # Resource: https://www.rubydoc.info/github/seattlerb/minitest/Minitest.after_run
    def _register_reports
      Minitest.after_run { Bdd.instance.run_reports! }
    end

    def group_class
      Minitest::Test
    end

    def current_example
      Minitest::Spec.current
    end

    def get_parent_groups(example)
      ret = []

      example.class.ancestors.each do |klass|
        break if klass.name.include? 'Minitest::'
        ret << klass
      end

      ret
    end

    def get_title(example_or_group)
      # example_or_group.instance_eval('@desc')
      example_or_group.name.split('::').last.split('_').last
    end

    # Resource: https://apidock.com/ruby/MiniTest/Assertions/assert
    # Resource: https://apidock.com/ruby/MiniTest/Assertions/skip
    def write(instance, example, keys, title, string, &block)
      data = instance.data
      if block_given?
        yield
        data.write(keys, :passed, title, string)
      else
        example.skip
      end
    rescue Minitest::Skip
      data.write(keys, :skipped, title, "#{string} (skipped)")
      raise
    rescue Minitest::Assertion
      data.write(keys, :failed, title, "#{string} (failed)")
      raise
    rescue => e
      data.write(keys, :failed, title, "#{string} (#{e.class}) #{e.message}")
      raise
    end
  end
end
