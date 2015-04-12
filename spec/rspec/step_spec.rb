require 'spec_helper'

describe Rspec::Step do
  # it 'has a version number' do
  #   expect(Rspec::Step::VERSION).not_to be nil
  # end

  # it 'does something useful' do
  #   expect(false).to eq(true)
  # end

  it "Works" do
    Given "something" do
      expect(true).to eq(true)
    end
    When "something" do
      expect(true).to eq(true)
    end
    Then "something" do
      expect(true).to eq(true)
    end
  end

end
