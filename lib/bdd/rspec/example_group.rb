module Bdd
  module RSpec
    module ExampleGroupSteps
      module ClassMethods
        def define_step(*names)
          steps.concat(names)
          names.each do |name|
            define_method(name) do |msg, &block|
              step([name, msg], &block)
            end
          end
        end
        def steps
          @steps
        end
      end

      def self.included(base)
        # initialize empty steps
        base.instance_variable_set(:@steps, [])
        # step needs access to the @steps - but it is not visible when extend is used, especially not as @@steps
        base.send(:define_method, :steps) { base.instance_variable_get(:@steps) }
        # add the `define_step` and `steps` class methods
        base.extend ClassMethods
      end

      def step(prefix_and_text, &block)
        unless using_bdd_formatter?
          yield if block_given?
          return
        end

        @max_length ||= steps.map(&:length).max

        if
          block_given?
        then
          if
            @is_during_rspec_step
          then
            yield
          else
            step_messages << hash = {msg: prefix_and_text, prefix_length: @max_length}
            @is_during_rspec_step = true
            yield
            # apply green color if example passes
            hash[:color] = :green
            @is_during_rspec_step = false
          end

        elsif
          prefix_and_text[1] == :bdd
        then
          last_message    = step_messages.last[:msg]
          last_message[0] = prefix_and_text[0]

        else
          step_messages << {msg: "SKIPPED #{prefix_and_text}"}
        end
        return :bdd
      end
    end

    module ExampleGroup
      include ExampleGroupSteps

      define_step(*%w[Given When Then And But])

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

      def self.included(base)
        base.extend ClassMethods
      end

      private

      def step_messages
        ::RSpec.current_example.metadata[:step_messages]
      end

      def using_bdd_formatter?
        !step_messages.nil?
      end
    end
  end
end
