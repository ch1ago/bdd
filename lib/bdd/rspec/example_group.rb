require "bdd/rspec/example_group_steps"

module Bdd
  module RSpec
    module ExampleGroup

      include ExampleGroupSteps

      define_bdd_step(*%w[Given When Then And But])

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

    end
  end
end
