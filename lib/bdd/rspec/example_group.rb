module Bdd
  module RSpec
    module ExampleGroup

      
      def step(array, &block)
        m = ::RSpec.current_example.metadata
        step_messages = m[:step_messages]
        
        if block_given?
          # m[:step_messages] << array #if m[:step_messages]
          if @is_during_rspec_step
            yield
          else
            step_messages << hash = {msg: array}
            @is_during_rspec_step = true
            yield
            # apply green color if example passes
            hash[:color] = :green
            @is_during_rspec_step = false
          end

        elsif array.last == :bdd
          a = step_messages.last[:msg]
          a[0] = array[0]
        else
          step_messages << {msg: "SKIPPED #{array}"}
        end
        return :bdd
      end

      def Given(msg, &block)
        step(["Given", msg], &block)
      end

      def When(msg, &block)
        step([" When", msg], &block)
      end

      def Then(msg, &block)
        step([" Then", msg], &block)
      end

      def And(msg, &block)
        step(["  And", msg], &block)
      end

      def But(msg, &block)
        step(["  But", msg], &block)
      end

      # def AndGiven(msg, &block)
      #   step("And Given #{msg}", &block)
      # end

      # def AndWhen(msg, &block)
      #   step(" And When #{msg}", &block)
      # end

      # def AndThen(msg, &block)
      #   step(" And Then #{msg}", &block)
      # end

      # def ButGiven(msg, &block)
      #   step("But Given #{msg}", &block)
      # end

      # def ButWhen(msg, &block)
      #   step(" But When #{msg}", &block)
      # end

      # def ButThen(msg, &block)
      #   step(" But Then #{msg}", &block)
      # end


    end
  end
end
