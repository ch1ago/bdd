require 'spec_helper'
require 'bdd/rspec'

describe Bdd::RSpec::Formatter do

  it "represents nested groups using hierarchy tree" do
    Bdd.define(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese

    suite.run(config.reporter)

    text = Bdd::Colors.clear(config.output_stream.string)

    expect(text).to eql("
root
  a certain context
    a complex example
       Given a condition W
             a condition X
         And a condition Y
        When an action is performed
        Then an outcome A happens
             and an outcome B happens
             an outcome W2 happens
    a simple example
       Given a condition W
             a condition
        When an action is performed
        Then an outcome happens
             an outcome W2 happens
    an unfinished example (PENDING: No reason given)
       Given a condition W
             a condition
        When an action is performed
        Then I need to keep writing the test
             an outcome W2 happens
    with another language
       Given a condition W
        Dado alguma coisa
           E alguma coisa
      Quando alguma coisa
       Entao alguma coisa
         Mas alguma coisa
        Then an outcome W2 happens
")
  end

  def config
    @config ||=
    RSpec.configuration.dup.tap do |config|
      config.reset
      config.default_formatter = described_class
      config.output_stream = StringIO.new
    end
  end

  def suite
    @suite ||=
    RSpec.describe("root").tap do |describe|
      describe.context("a certain context").tap do |context|

        context.Given("a condition W") { }

        context.example("a complex example") do
          Given("a condition X") { }
          And("a condition Y") {
            Then("overwrite happened - SHOULD NOT SHOW") {
              But("it did nothing - NEITHER SHOULD THIS") {  }
            }
          }

          When("an action is performed") {}

          Then("an outcome A happens") {}
          Then("and an outcome B happens") {}
        end

        context.example("a simple example") do
          Given("a condition") {}

          When("an action is performed") {}

          Then("an outcome happens") {}
        end

        context.example("an unfinished example") do
          Given("a condition") {}

          When("an action is performed") {}

          Then("I need to keep writing the test")
        end

        context.example("with another language") do
          Dado("alguma coisa") {}
          E("alguma coisa") {}
          Quando("alguma coisa") {}
          Entao("alguma coisa") {}
          Mas("alguma coisa") {}
        end

        context.Then("an outcome W2 happens") { }
      end
    end
  end
end
