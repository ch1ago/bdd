require 'bdd/colors'

RSpec::Support.require_rspec_core "formatters/documentation_formatter"

module Bdd
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::DocumentationFormatter

      DEFAULT_PREFIX_LENGTH   = 5

      ::RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished,
                                         :example_started, :example_passed,
                                         :example_pending, :example_failed

      def example_started(notification)
        notification.example.metadata[:bdd_step_messages] = []
      end

      def example_passed(passed)
        super
        output.puts read_steps(passed.example, :green)
      end

      def example_pending(pending)
        super
        output.puts read_steps(pending.example, :yellow)
      end

      def example_failed(failure)
        super
        output.puts read_steps(failure.example, :red)
      end

    private

      def read_steps(example, text_color)
        last_step_prefix = ""
        prefix_length    = example.metadata[:bdd_prefix_max_length]

        example.metadata[:bdd_step_messages].map do |msg|
          if
            msg.is_a? Array
          then
            prefix, text = msg
            if
              prefix == last_step_prefix
            then
              prefix = blank_step_prefix(prefix_length)
            else
              last_step_prefix = prefix
              prefix = "%#{prefix_length}s" % prefix if prefix_length
              prefix = Colors.add_color(prefix, :white)
            end

            msg = [prefix, Colors.add_color(text, text_color)].join(' ')
          end
          [next_indentation, msg].join('')
        end
      end

      def blank_step_prefix(length)
        length ||= DEFAULT_PREFIX_LENGTH
        "%#{length}s" % ""
      end

      def next_indentation
        '  ' * (@group_level+1)
      end

    end
  end
end
