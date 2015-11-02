require 'spec_helper'

describe 'Zombie' do

  it 'is alive' do
    Given 'pre-condition A' do
      expect(1).to eq(1)
    end

    When 'it performs action B' do
      expect(1).to eq(1)
    end

    Then 'post-condition AB is expected' do
      expect(1).to eq(1)
    end

    Then 'and it is stil a zombie' do
      expect(1).to eq(1)
    end
  end

  it 'is dead' do
    Given 'pre-condition A' do
      expect(1).to eq(1)
    end

    When 'it performs action C' do
      expect(1).to eq(1)
    end

    Then 'post-condition AC is expected' do
      expect(1).to eq(1)
    end

    Then 'and it is stil a zombie' do
      expect(1).to eq(1)
    end
  end

end

