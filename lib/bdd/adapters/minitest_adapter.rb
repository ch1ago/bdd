module Bdd
  module Adapters
    class MinitestAdapter < Base

      def initialize
        @example_module          = Test
        @formatter_module        = Reporter
        @formatter_class         = Bdd::Minitest::Reporter
        @framework_example_class = ::Minitest::Test
      end

      module Reporter
        def record_print_status(test)
          super
          if test.bdd_container.any?
            puts test.bdd_container
            puts
          end
          test.bdd_container.clear
        end
      end

      module Test
        def bdd_step(title, string, &block)
          @bdd_nesting ||= 0
          @bdd_nesting += 1
          sb = StringBuilder.new(title)

          if block_given?
            yield
            sb.append_success(string)
          else
            skip
          end

        rescue ::Minitest::Skip
          sb.append_pending(string)
          raise
        rescue ::Minitest::Assertion
          sb.append_failure(string)
          raise
        ensure
          @bdd_nesting -= 1
          if @bdd_nesting.zero?
            bdd_container << sb.string
          end
        end

        def bdd_container
          @bdd_container ||= Bdd.get_container(object_id)
        end
      end

    end
  end
end
