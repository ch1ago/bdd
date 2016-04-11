require 'spec_helper'

class Zombie
  def initialize
    @brains = 0
  end
  def eat(brains)
    @brains += brains
  end
  def hungry?
    @brains < 3
  end
end

describe Zombie do

  let (:zombie) { Zombie.new }

  it "Is naturally hungry" do
    Given "zombie is instantiated" do
      zombie
    end
    Then "zombie should be hungry" do
      expect(zombie.hungry?).to eq(true)
    end

  end

  it "Does not satisfy with 1 brain" do
    # this comment
    When "zombie eats 1 brain" do
      zombie.eat(1)
    end
    # does not show in your test output
    Then "zombie should still be hungry" do
      expect(zombie.hungry?).to eq(true)
    end
  end

  it "Does not satisfy with 2 brains" do
    # so start using bdd gem today
    When "zombie eats 2 brains" do
      zombie.eat(2)
    end
    # and make your tests STAND OUT
    Then "zombie should no longer hungry" do
      expect(zombie.hungry?).to eq(false)
    end
  end
end
