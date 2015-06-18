RSpec::Support.require_rspec_core "formatters/documentation_formatter"

module Bdd
  module RSpec
    class Formatter < ::RSpec::Core::Formatters::DocumentationFormatter

      ::RSpec::Core::Formatters.register self, :example_group_started, :example_group_finished,
                                         :example_started, :example_passed,
                                         :example_pending, :example_failed

      def example_started(notification)
        notification.example.metadata[:step_messages] = []
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
        example.metadata[:step_messages].map do |hash|
          msg   = hash[:msg]
          color = hash[:color] || color2 || :light_black
          if msg.is_a? Array
            msg0 =  if msg[0] == last_step_title
                      blank_step_title
                    else
                      msg[0].light_white.bold
                    end
            last_step_title = msg[0]

            msg = [msg0, msg[1].colorize(color)].join(' ')
          end
          # light_black doesn't really get used because the test failure prevents other messages from being added
          r = [next_indentation, msg]
          r.join(' ')
        end
      end

      def blank_step_title
        "     "
      end

      def next_indentation
        '  ' * (@group_level+1)
      end

    end
  end
end
