module Bdd
  class Configuration
    attr_writer :framework
    attr_reader :instance

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
      LanguageAdapter.add(
        instance,
        pre_conditions,
        post_conditions,
        conjunctions
      )
    end

    def reporters(*args)
      return @reporters if args.empty? && !@reporters.nil?
      @reporters = ReportAdapter.list(*args)
    end
  end
end
