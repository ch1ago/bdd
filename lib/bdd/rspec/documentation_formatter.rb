# https://raw.githubusercontent.com/rspec/rspec-core/v3.2.2/lib/rspec/core/formatters/documentation_formatter.rb

RSpec::Support.require_rspec_core "formatters/base_text_formatter"

module RSpec
  module Core
    module Formatters
      
      # @private
      class DocumentationFormatter < BaseTextFormatter

        def initialize(output)
          super
          @group_level = 0
        end


        def example_started(notification)
          notification.example.metadata[:step_messages] = []
        end

        def example_group_started(notification)
          output.puts if @group_level == 0
          output.puts "#{current_indentation}#{notification.group.description.strip}"

          @group_level += 1
        end

        def example_group_finished(_notification)
          @group_level -= 1
        end

        def example_passed(passed)
          output.puts passed_output(passed.example)
          output.puts read_steps(passed.example)
        end

        def example_pending(pending)
          output.puts pending_output(pending.example,
                                     pending.example.execution_result.pending_message)
          output.puts read_steps(pending.example, :yellow)
        end

        def example_failed(failure)
          output.puts failure_output(failure.example,
                                     failure.example.execution_result.exception)
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

        def current_indentation
          '  ' * @group_level
        end

        def next_indentation
          '  ' * (@group_level+1)
        end

      end
    end
  end
end
