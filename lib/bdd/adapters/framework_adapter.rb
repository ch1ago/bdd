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

      groups = framework.get_parent_groups(example)
      groups.reverse_each do |group|
        ret << framework.get_title(group)
      end
      ret << framework.get_title(example)

      ret
    end
  end
end
