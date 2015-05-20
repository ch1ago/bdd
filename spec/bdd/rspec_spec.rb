require 'spec_helper'

describe Bdd::RSpec do

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end

  def nested
    Given "1.1 something" do
      expect(true).to eq(true)
    end
  end

  it "Works" do
    Given "1 something" do
      expect(true).to eq(true)
    end
    But nested
    When "2 something" do
      expect(true).to eq(true)
    end
    And "3 something" do
      expect(true).to eq(true)
    end
    Then "4 something" do
      expect(true).to eq(true)
    end
    Then "5 something" do
      expect(true).to eq(true)
    end
  end

end
