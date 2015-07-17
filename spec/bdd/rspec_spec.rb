require 'spec_helper'
require 'support/rspec_formatter_support'

describe Bdd::RSpec::Formatter do
  include RSpecFormatterSupport

  before do
    allow(::RSpec.configuration).to receive(:color_enabled?).and_return false
  end

  it "represents nested groups using hierarchy tree" do
    suite = RSpec.describe("root").tap do |describe|
      describe.context("a certain context").tap do |context|

        context.example("a complex example") do
          Given("given a condition X") { }
          And("a condition Y") {}

          When("an action is performed") {}

          Then("an outcome A happens") {}
          Then("and an outcome B happens") {}
        end

        context.example("a simple example") do
          Given("given a condition") {}

          When("an action is performed") {}

          Then("an outcome happens") {}
        end
      end
    end

    suite.run(reporter)

    expect(formatter_output.string).to eql("
root
  a certain context
    a complex example
       Given given a condition X
         And a condition Y
        When an action is performed
        Then an outcome A happens
             and an outcome B happens
    a simple example
       Given given a condition
        When an action is performed
        Then an outcome happens
")
  end
end
