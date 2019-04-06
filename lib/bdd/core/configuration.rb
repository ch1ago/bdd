module Bdd
  class Configuration
    attr_writer :framework
    attr_reader :instance

    class Error < StandardError; end
    class MustSetFrameworkFirst < Error; end

    def initialize(instance)
      @instance = instance
    end

    def framework(symbol = nil)
      return @framework if symbol.nil?
      @framework = FrameworkAdapter.get(symbol)
      @framework.register!
      @framework
    end

    def language(pre_conditions, post_conditions, conjunctions)
      self.pre_conditions(pre_conditions)
      self.post_conditions(post_conditions)
      self.conjunctions(conjunctions)
    end

    def pre_conditions(*strings)
      conjunctions(*strings)
      strings.flatten.each { |string| FrameworkAdapter.define_context_method_with_before_each(instance, string) }
    end

    def post_conditions(*strings)
      conjunctions(*strings)
      strings.flatten.each { |string| FrameworkAdapter.define_context_method_with_after_each(instance, string) }
    end

    def conjunctions(*strings)
      raise MustSetFrameworkFirst if framework.nil?
      strings.flatten.each { |string| FrameworkAdapter.define_example_method(instance, string) }
    end

    def reports(*args)
      return @reports if args.empty? && !@reports.nil?
      @reports = ReportAdapter.list(*args)
    end
  end
end
