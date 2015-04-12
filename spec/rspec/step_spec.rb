require 'spec_helper'

describe Rspec::Step do
  it 'has a version number' do
    expect(Rspec::Step::VERSION).not_to be nil
  end

  it 'does something useful' do
    expect(false).to eq(true)
  end
end
