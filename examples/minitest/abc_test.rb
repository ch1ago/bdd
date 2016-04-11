$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'bdd/minitest'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

describe 'BDD' do
  describe "abc" do
    before(:each) do
      Given 'it works with explicit filters' do
        assert true
      end
    end

    Given 'it works with implicit filters' do
      assert true
    end

    it "has love" do
      Given "it has some love" do
        assert true
      end
      When "it needs love" do
        assert true
      end
      Then "it has love" do
        assert true
      end
    end

    it "doesn't has love" do
      Given "it does not have love" do
        assert true
      end
      When "it needs love" do
        assert true
      end
      Then "it has no love (this is failing on purpose for demo)" do
        assert false
      end
    end
  end
end
