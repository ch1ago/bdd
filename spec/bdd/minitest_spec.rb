require 'spec_helper'
require 'bdd/minitest'

class TestAbc < Minitest::Spec

  Given("a condition W") { }

  def test_a_complex_example
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

  def test_a_simple_example
    Given("a condition") {}

    When("an action is performed") {}

    Then("an outcome happens") {}
  end

  def test_an_unfinished_example
    Given("a condition") {}

    When("an action is performed") {}

    Then("I need to keep writing the test")
  end

  def test_with_another_language
    Dado("alguma coisa") {}
    E("alguma coisa") {}
    Quando("alguma coisa") {}
    Entao("alguma coisa") {}
    Mas("alguma coisa") {}
  end

  Then("an outcome W2 happens") { }

end


describe Minitest::Reporters::SpecReporter do
  before do
    @test = TestAbc.new('')
    @reporter = Bdd::Minitest::Reporter.new
    @reporter.io = StringIO.new
    Minitest::Reporters.use!(@reporter)
    Bdd.define(%w[Dado], %w[Quando Entao], %w[E Mas]) # Portuguese
  end

  def run_test(name)
    @test.name = name
    @test.run
    @reporter.record(@test)
  end

  it "test a_simple_example" do
    run_test 'test_a_simple_example'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_a_simple_example                                           PASS (0.00s)
 Given a condition W
       a condition
  When an action is performed
  Then an outcome happens
       an outcome W2 happens

")
  end

  it "test a_complex_example" do
    run_test 'test_a_complex_example'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_a_complex_example                                          PASS (0.00s)
 Given a condition W
       a condition X
   And a condition Y
  When an action is performed
  Then an outcome A happens
       and an outcome B happens
       an outcome W2 happens

")
  end

  it "test an_unfinished_example" do
    run_test 'test_an_unfinished_example'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_an_unfinished_example                                      SKIP (0.00s)
 Given a condition W
       a condition
  When an action is performed
  Then I need to keep writing the test
       an outcome W2 happens

")
  end

  it "test with_another_language" do
    run_test 'test_with_another_language'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_with_another_language                                      PASS (0.00s)
 Given a condition W
  Dado alguma coisa
     E alguma coisa
Quando alguma coisa
 Entao alguma coisa
   Mas alguma coisa
  Then an outcome W2 happens

")
  end

end
