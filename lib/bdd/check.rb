module Bdd
  class Check

    def initialize
      if not $SKIP_BDD_CHECK === true
        if not has_loaded_with_a_test_framework?
          print_out
          fail SyntaxError, "Update your Gemfile"
        end
      end
    end

    private

    def has_loaded_with_a_test_framework?
      rspec? || minitest?
    end

    def rspec?
      defined? Bdd::RSpec
    end

    def minitest?
      defined? Bdd::Minitest
    end

    def print_out
      5.times { puts }

      print Colors.add("Please edit your ", :red)
      print Colors.add("Gemfile ", :yellow)
      puts Colors.add("to", :red)
      puts
      if rspec?
        puts Colors.add("gem 'bdd', require: 'bdd/rspec' ", :light_white)
      elsif minitest?
        puts Colors.add("gem 'bdd', require: 'bdd/minitest' ", :light_white)
      else
        fail "This was not supposed to happen"
      end
      puts

      print Colors.add("LEARN MORE AT ", :red)
      puts Colors.add("https://github.com/thejamespinto/bdd", :light_green)

      5.times { puts }
    end

  end
end
