RSpec::Support.require_rspec_core "formatters/documentation_formatter"

module Bdd
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::DocumentationFormatter

      DEFAULT_PREFIX_LENGTH = 5

      ::RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished,
                                         :example_started, :example_passed,
                                         :example_pending, :example_failed

      def example_started(notification)
        notification.example.metadata[:bdd_step_messages] = []
      end

      def example_passed(passed)
        super
        output.puts read_steps(passed.example)
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

      def read_steps(example, color2=nil)
        last_step_title = ""
        prefix_length   = example.metadata[:bdd_prefix_max_length]

        example.metadata[:bdd_step_messages].map do |hash|
          msg   = hash[:msg]
          color = hash[:color] || color2 || :light_black
          if
            msg.is_a? Array
          then
            msg0 = msg[0]
            if
              msg0 == last_step_title
            then
              msg0 = blank_step_title(prefix_length)
            else
              last_step_title = msg0
              msg0 = "%#{prefix_length}s" % msg0 if prefix_length
              msg0 = text_with_color(msg0, :white)
            end

            msg = [msg0, text_with_color(msg[1], color)].join(' ')
          end
          # light_black doesn't really get used because the test failure prevents other messages from being added
          r = [next_indentation, msg]
          r.join(' ')
        end
      end

      def blank_step_title(length)
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
          text.colorize(color)
        else
          text
        end
      end

    end
  end
end
