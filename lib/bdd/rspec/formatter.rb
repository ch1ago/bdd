RSpec::Support.require_rspec_core "formatters/documentation_formatter"

module Bdd
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::DocumentationFormatter

      DEFAULT_PREFIX_LENGTH   = 5

      SHELL_COLORS_DEFINITION =
      {
        :black   => 30, :light_black    => 90,
        :red     => 31, :light_red      => 91,
        :green   => 32, :light_green    => 92,
        :yellow  => 33, :light_yellow   => 93,
        :blue    => 34, :light_blue     => 94,
        :magenta => 35, :light_magenta  => 95,
        :cyan    => 36, :light_cyan     => 96,
        :white   => 37, :light_white    => 97,
        :default => 39
      }

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
              prefix = text_with_color(prefix, :white)
            end

            msg = [prefix, text_with_color(text, text_color)].join(' ')
          end
          [next_indentation, msg].join(' ')
        end
      end

      def blank_step_prefix(length)
        length ||= DEFAULT_PREFIX_LENGTH
        "%#{length}s" % ""
      end

      def next_indentation
        '  ' * (@group_level+1)
      end

    private

      def text_with_color(text, color)
        if
          ::RSpec.configuration.color_enabled?
        then
          "\033[#{SHELL_COLORS_DEFINITION[color]}m#{text}\033[0m"
        else
          text
        end
      end

    end
  end
end
