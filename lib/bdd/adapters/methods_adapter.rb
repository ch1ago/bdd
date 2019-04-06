module Bdd
  module MethodsAdapter
    module_function

    #
    # Defines a method (Given, When, Then, And, But, ...)
    # that can be called from the example block
    #
    def define_on_example(instance, method_name)
      fgc = instance.configuration.framework.group_class
      fgc.send(:define_method, method_name) do |string, &block|
        FrameworkAdapter.write(
          instance,
          method_name,
          string,
          &block
        )
      end
    end

    #
    # Defines a method (Given, ...)
    # that can be called from the context block
    #
    def define_before_example(instance, method_name)
      fgmm = instance.configuration.framework.group_methods_module
      fgmm.send(:define_method, method_name) do |string, &block|
        before(:each) do
          send(method_name, string) do
            if block
              instance_eval(&block)
            else
              skip
            end
          end
        end
      end
    end

    #
    # Defines a method (When, Then, ...)
    # that can be called from the context block
    #
    def define_after_example(instance, method_name)
      fgmm = instance.configuration.framework.group_methods_module
      fgmm.send(:define_method, method_name) do |string, &block|
        after(:each) do
          send(method_name, string) do
            if block
              instance_eval(&block)
            else
              skip
            end
          end
        end
      end
    end
  end
end
