# rspec abc_spec.rb

$LOAD_PATH.unshift File.expand_path('../../../lib', __FILE__)

require 'bdd/rspec'

RSpec.configure do |config|
  config.color = true
  config.default_formatter = Bdd::RSpec::Formatter
end

describe 'BDD' do
  describe "abc" do
    before(:each) do
      Given 'it works with explicit filters' do
        expect(true).to eq true
      end
    end

    Given 'it works with implicit filters' do
      expect(true).to eq true
    end

    it "has love" do
      Given "it has some love" do
        expect(true).to eq true
      end
      When "it needs love" do
        expect(true).to eq true
      end
      Then "it has love" do
        expect(true).to eq true
      end
    end

    it "doesn't has love" do
      Given "it does not have love" do
        expect(true).to eq true
      end
      When "it needs love" do
        expect(true).to eq true
      end
      Then "it has no love (this is failing on purpose for demo)" do
        expect(true).to eq false
      end
    end

    it "will love" do
      Given "it does not have love" do
        expect(true).to eq true
      end
      When "it needs love" do
        expect(true).to eq true
      end
      Then "it will love later (this is failing on purpose for demo)"
    end
  end
end
