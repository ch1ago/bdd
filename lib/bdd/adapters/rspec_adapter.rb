module Bdd
  module Adapters
    class RSpecAdapter < Base

      def initialize
        super(
          ExampleGroup,
          Formatter,
          Bdd::RSpec::Formatter,
          ::RSpec::Core::ExampleGroup
        )
      end

      def register
        super
        ::RSpec::Core::Formatters.register(Bdd::RSpec::Formatter)
      end

      module Formatter
        def example_passed(passed)
          super
          bdd_puts(passed.example)
        end

        def example_pending(pending)
          super
          bdd_puts(pending.example)
        end

        def example_failed(failure)
          super
          bdd_puts(failure.example)
        end

      private

        def bdd_puts(example)
          bdd_container = Bdd.get_container(example)
          next_indentation = '  ' * (@group_level+1)
          output.puts bdd_container.map { |message| "#{next_indentation}#{message}" }
          bdd_container.clear
        end
      end

      module ExampleGroup
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

        rescue ::RSpec::Core::Pending::SkipDeclaredInExample
          sb.append_pending(string)
          raise
        rescue ::RSpec::Expectations::ExpectationNotMetError
          sb.append_failure(string)
          raise
        ensure
          @bdd_nesting -= 1
          if @bdd_nesting.zero?
            bdd_container << sb.string
          end
        end

        def bdd_container
          Bdd.get_container(::RSpec.current_example)
        end
      end

    end
  end
end
