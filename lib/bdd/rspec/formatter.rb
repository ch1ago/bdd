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
        prefix_length    = example.metadata[:bdd_prefix_max_length] || DEFAULT_PREFIX_LENGTH

        example.metadata[:bdd_step_messages].map do |prefix, text|
          if
            prefix == last_step_prefix
          then
            prefix = ""
          else
            last_step_prefix = prefix
          end

          prefix = adjust_length(prefix, prefix_length)
          prefix = add_color(prefix, :white)
          text   = add_color(text, text_color)

          "#{next_indentation}#{prefix} #{text}"
        end
      end

      def adjust_length(text, length)
        "%#{length}s" % text
      end

      def add_color(text, color, mode = :default)
        if
          ::RSpec.configuration.color_enabled?
        then
          Colors.add_color(text, color, mode)
        else
          text
        end
      end

      def next_indentation
        '  ' * (@group_level+1)
      end

    end
  end
end
