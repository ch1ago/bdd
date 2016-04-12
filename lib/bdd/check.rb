module Bdd
  class Check

    def initialize
      if not $SKIP_BDD_CHECK === true
        if has_defined_any_test_framework?
          print_out
          fail SyntaxError, "Update your Gemfile"
        end
      end
    end

    private

    def has_defined_any_test_framework?
      rspec? || minitest?
    end

    def rspec?
      defined? RSpec
    end

    def minitest?
      defined? Minitest
    end

    def print_out
      5.times { puts }

      print "Please edit your ".red
      print "Gemfile ".yellow
      print "to ".red
      if rspec?
        puts "gem 'bdd', require: 'bdd/rspec' ".light_white
      elsif minitest?
        puts "gem 'bdd', require: 'bdd/minitest' ".light_white
      else
        fail "This was not supposed to happen"
      end
      puts

      print "LEARN MORE AT ".red
      puts "https://github.com/thejamespinto/bdd".light_green

      5.times { puts }
    end

  end
end
