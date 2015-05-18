require 'spec_helper'

describe Bdd::RSpec do

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end

  it "Works" do
    Given "something" do
      expect(true).to eq(true)
    end
    But "something" do
      expect(true).to eq(true)
    end
    When "something" do
      expect(true).to eq(true)
    end
    And "something" do
      expect(true).to eq(true)
    end
    Then "something" do
      expect(true).to eq(true)
    end
    Then "something" do
      expect(true).to eq(true)
    end
  end

end
