require 'colorize'
require 'bdd/version'

require 'minitest'
require 'minitest/reporters'
require 'minitest/spec' # I don't understand why this does not load automatically


#
# Adding behavior to minitest
#
module Kernel
  def bdd_step(title, string, &block)
    final_string = "    #{title} ".white.bold
    yield
    final_string << string.green
  rescue ::Minitest::Assertion
    final_string << string.red
    raise
  ensure
    Minitest::Bdd.messages << final_string
  end

  def Given(string, &block)
    bdd_step('Given', string, &block)
  end

  def When(string, &block)
    bdd_step(' When', string, &block)
  end

  def Then(string, &block)
    bdd_step(' Then', string, &block)
  end

  def And(string, &block)
    bdd_step('  And', string, &block)
  end

  def But(string, &block)
    bdd_step('  But', string, &block)
  end
end


module Minitest
  module Bdd
    #
    # This is a simple shortcut
    #
    class << self
      def messages
        Minitest::Spec.current.bdd_messages
      end
    end

    #
    # Adding behavior to minitest
    #
    module Test
      def bdd_messages
        @bdd_messages ||= []
      end

      module ClassMethods
        def Given(msg, &block)
          before(:each) do
            Given(msg) { instance_eval(&block) }
          end
        end

        def When(msg, &block)
          after(:each) do
            When(msg) { instance_eval(&block) }
          end
        end

        def Then(msg, &block)
          after(:each) do
            Then(msg) { instance_eval(&block) }
          end
        end
      end
    end
  end

  Test.send :include, Bdd::Test
  Test.send :extend, Bdd::Test::ClassMethods

  #
  # Adding behavior to minitest-reporters
  #
  Reporters::SpecReporter.class_eval do
    def record(test)
      super
      test_name = test.name.gsub(/^test_: /, 'test:')
      print pad_test(test_name)
      print_colored_status(test)
      print(" (%.2fs)" % test.time) unless test.time.nil?
      puts

      record_hook_before_print_failures(test)

      if !test.skipped? && test.failure
        print_info(test.failure)
        puts
      end
    end

    def record_hook_before_print_failures(test)
      if Minitest::Bdd.messages.any?
        puts Minitest::Bdd.messages
        puts
      end
    end
  end
end
