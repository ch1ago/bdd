require 'spec_helper'

require 'bdd/minitest'
require 'bdd/rspec'

class MinitestExperiment
  include Bdd::Adapters::MinitestAdapter::Test
end

class RspecExperiment
  include Bdd::Adapters::RSpecAdapter::ExampleGroup
end

describe Bdd do
  describe ".define is a deprecated method" do
    it "works" do
      expect {
        Bdd.define("Pirate")
      }.to raise_error(RuntimeError)
    end
  end
end

describe Bdd::Adapters::MinitestAdapter::Test do
  describe ".bdd_step" do
    describe "the ::Minitest::Assertion exception" do

      it "works when the exception is not raised" do
        expect_any_instance_of(Bdd::StringBuilder).to receive(:append_success)
        expect_any_instance_of(Bdd::StringBuilder).not_to receive(:append_failure)

        expect {
          MinitestExperiment.new.bdd_step("title", "string") do
          end
          }.not_to raise_error
      end

      it "works when the exception is raised" do
        expect_any_instance_of(Bdd::StringBuilder).not_to receive(:append_success)
        expect_any_instance_of(Bdd::StringBuilder).to receive(:append_failure)

        expect {
          MinitestExperiment.new.bdd_step("title", "string") do
            raise ::Minitest::Assertion
          end
        }.to raise_error(::Minitest::Assertion)
      end
    end
  end
end

describe Bdd::Adapters::RSpecAdapter::ExampleGroup do
  describe ".bdd_step" do
    describe "the ::RSpec::Expectations::ExpectationNotMetError exception" do

      it "works when the exception is not raised" do
        expect_any_instance_of(Bdd::StringBuilder).to receive(:append_success)
        expect_any_instance_of(Bdd::StringBuilder).not_to receive(:append_failure)

        expect {
          RspecExperiment.new.bdd_step("title", "string") do
          end
          }.not_to raise_error
      end

      it "works when the exception is raised" do
        expect_any_instance_of(Bdd::StringBuilder).not_to receive(:append_success)
        expect_any_instance_of(Bdd::StringBuilder).to receive(:append_failure)

        expect {
          RspecExperiment.new.bdd_step("title", "string") do
            raise ::RSpec::Expectations::ExpectationNotMetError
          end
        }.to raise_error(::RSpec::Expectations::ExpectationNotMetError)
      end
    end
  end
end
