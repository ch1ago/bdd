# https://raw.githubusercontent.com/rspec/rspec-core/v3.2.2/lib/rspec/core/formatters/documentation_formatter.rb
# require "rspec/core/formatters/documentation_formatter"

RSpec::Support.require_rspec_core "formatters/base_text_formatter"

class RSpec::Core::ExampleGroup
  def step(msg)
    m = RSpec.current_example.metadata
    
    if block_given?
      # m[:step_messages] << msg #if m[:step_messages]
      if @is_during_rspec_step
        yield
      else
        m[:step_messages] << hash = {msg: msg}
        @is_during_rspec_step = true
        yield
        # apply green color if example passes
        hash[:color] = :green
        @is_during_rspec_step = false
      end
    else
      m[:step_messages] << {msg: "SKIPPED #{msg}"}
    end
  end

  def Given(msg, &block)
    step("Given #{msg}", &block)
  end

  def When(msg, &block)
    step("When  #{msg}", &block)
  end

  def Then(msg, &block)
    step("Then  #{msg}", &block)
  end
end


module RSpec
  module Core
    module Formatters
      # @private
      class DocumentationFormatter < BaseTextFormatter
        Formatters.register self
        # , :example_group_started, :example_group_finished,
        #                     :example_passed, :example_pending, :example_failed

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
          example.metadata[:step_messages].map do |hash|
            msg   = hash[:msg]
            color = hash[:color] || color2 || :light_black
            # light_black doesn't really get used because the test failure prevents other messages from being added
            "#{next_indentation}- #{msg}".colorize(color)
          end
        end


        def next_failure_index
          @next_failure_index ||= 0
          @next_failure_index += 1
        end

        def current_indentation
          '  ' * @group_level
        end

        def next_indentation
          '  ' * (@group_level+1)
        end

        def example_group_chain
          example_group.parent_groups.reverse
        end
      end
    end
  end
end
