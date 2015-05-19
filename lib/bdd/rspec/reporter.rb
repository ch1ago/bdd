module Bdd
  module RSpec
    module Reporter

      def __bdd_registered_formatters
        @listeners.values.map(&:to_a).flatten.uniq
      end

      def __bdd_find_registered_formatter(klass)
        __bdd_registered_formatters.detect { |formatter| formatter.class == klass }
      end

    end
  end
end
