module Bdd
  #
  # This procedural module mediates framework-agnostic and framework-specific code
  #
  module FrameworkAdapter
    module_function

    class Error < StandardError; end
    class InvalidInput < Error; end

    #
    # A factory method
    #
    def get(symbol)
      name = "Bdd::#{symbol.to_s.capitalize}Framework"
      Object.const_get(name)
    rescue NameError
      raise InvalidInput, <<-STR
#{symbol} is not a valid input
because it means there needs to be a module named #{name}.
Valid inputs are one of these: [:rspec, :minitest]
STR
    end

    #
    # Mediates framework-agnostic and framework-specific code
    #
    def write(instance, title, string, &block)
      framework = instance.configuration.framework
      example = framework.current_example

      node_keys = get_titles_for(
        framework,
        example
      )

      framework.write(
        instance,
        example,
        node_keys,
        title,
        string,
        &block
      )
    end

    #
    # Mediates framework-agnostic and framework-specific code
    #
    def get_titles_for(framework, example)
      ret = []

      framework.get_parent_groups(example).reverse_each do |group|
        ret << framework.get_title(group)
      end
      ret << framework.get_title(example)

      ret
    end

    #
    # Defines a method (Given, When, Then, ...)
    # that can be called from the example block
    #
    def define_example_method(instance, method_name)
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
    # Defines a method (Given, When, Then, ...)
    # that can be called from the context block
    #
    def define_context_method_with_before_each(instance, method_name)
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
    # Defines a method (Given, When, Then, ...)
    # that can be called from the context block
    #
    def define_context_method_with_after_each(instance, method_name)
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
