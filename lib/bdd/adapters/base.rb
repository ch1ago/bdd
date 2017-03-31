module Bdd
  module Adapters
    class Base
      def self.register
        Bdd.adapters << adapter = new
        adapter.register
        Bdd.add_language(%w[Given], %w[When Then], %w[And But])
      end

      def initialize(example_module, formatter_module, formatter_class, framework_example_class)
        @example_module          = example_module
        @formatter_module        = formatter_module
        @formatter_class         = formatter_class
        @framework_example_class = framework_example_class
      end

      def register
        # implementation must set these ivars
        @example_module.const_set(:ClassMethods, Module.new)
        @formatter_class.send :include, @formatter_module
        @framework_example_class.send :include, @example_module
        @framework_example_class.send :extend,  @example_module::ClassMethods
      end

      def define(pre_conditions, post_conditions, conjunctions)
        _define_conditions(:before, pre_conditions)
        _define_conditions(:after, post_conditions)
        _define_conjunctions(conjunctions)
      end

      private

      def _define_conditions(placement, titles)
        titles.each do |title|
          @example_module::ClassMethods.send :define_method, title do |string, &block|
            send(placement, :each) do
              send(title, string) do
                instance_eval(&block)
              end
            end
          end
        end
      end

      def _define_conjunctions(titles)
        titles.each do |title|
          @example_module.send :define_method, title do |string, &block|
            bdd_step(title, string, &block)
          end
        end
      end
    end
  end
end
