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
       Given a condition W (first)
             a condition X (1)
         And a condition Y (2)
        When an action is performed (3)
        Then an outcome A happens (4)
             and an outcome B happens (5)
             an outcome W2 happens (last)
    a simple example
       Given a condition W (first)
             a condition (1)
        When an action is performed (2)
        Then an outcome happens (3)
             an outcome W2 happens (last)
    an unfinished example (PENDING: No reason given)
       Given a condition W (first)
             a condition (1)
        When an action is performed (2)
        Then I need to keep writing the test (3)
             an outcome W2 happens (last)
    with another language
       Given a condition W (first)
        Dado alguma coisa (1)
           E alguma coisa (2)
      Quando alguma coisa (3)
       Entao alguma coisa (4)
         Mas alguma coisa (5)
        Then an outcome W2 happens (last)
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

        context.Given("a condition W (first)") { }

        context.example("a complex example") do
          Given("a condition X (1)") { }
          And("a condition Y (2)") {
            Then("overwrite happened - SHOULD NOT SHOW (hidden)") {
              But("it did nothing - NEITHER SHOULD THIS (hidden)") {  }
            }
          }

          When("an action is performed (3)") {}

          Then("an outcome A happens (4)") {}
          Then("and an outcome B happens (5)") {}
        end

        context.example("a simple example") do
          Given("a condition (1)") {}

          When("an action is performed (2)") {}

          Then("an outcome happens (3)") {}
        end

        context.example("an unfinished example") do
          Given("a condition (1)") {}

          When("an action is performed (2)") {}

          Then("I need to keep writing the test (3)")
        end

        context.example("with another language") do
          Dado("alguma coisa (1)") {}
          E("alguma coisa (2)") {}
          Quando("alguma coisa (3)") {}
          Entao("alguma coisa (4)") {}
          Mas("alguma coisa (5)") {}
        end

        context.Then("an outcome W2 happens (last)") { }
      end
    end
  end
end
