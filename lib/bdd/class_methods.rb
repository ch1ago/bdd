module Bdd
  class << self
    def adapters
      @adapters ||= []
    end

    def define(*)
      raise "`BDD.define` has been DEPRECTEAD, please use `Bdd.add_language` instead."
    end

    def add_language(pre_conditions, post_conditions, conjunctions)
      conjunctions += pre_conditions + post_conditions
      x = conjunctions.map(&:length).max
      Title.length = x

      adapters.each do |a|
        a.define(pre_conditions, post_conditions, conjunctions)
      end
    end

    def get_container(example)
      @containers ||= {}
      @containers[example] ||= []
    end
  end
end
