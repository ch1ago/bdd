module Bdd
  module LanguageAdapter
    module_function

    class Error < StandardError; end
    class MustSetFrameworkFirst < Error; end

    def add(instance, pre_conditions, post_conditions, conjunctions)
      raise MustSetFrameworkFirst if instance.configuration.framework.nil?

      _add_pre_conditions(instance, pre_conditions)
      _add_conjunctions(instance, pre_conditions)

      _add_post_conditions(instance, post_conditions)
      _add_conjunctions(instance, post_conditions)

      _add_conjunctions(instance, conjunctions)
    end

    def _add_pre_conditions(instance, *strings)
      strings.flatten.each do |string|
        MethodsAdapter.define_before_example(
          instance,
          string
        )
      end
    end

    def _add_post_conditions(instance, *strings)
      strings.flatten.each do |string|
        MethodsAdapter.define_after_example(
          instance,
          string
        )
      end
    end

    def _add_conjunctions(instance, *strings)
      strings.flatten.each do |string|
        MethodsAdapter.define_on_example(
          instance,
          string
        )
      end
    end
  end
end
