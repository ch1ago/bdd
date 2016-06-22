require 'spec_helper'
require 'bdd/minitest'

class TestAbc < Minitest::Spec

  Given("a condition W (first)") { }

  def test_a_complex_example
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

  def test_a_simple_example
    Given("a condition (1)") {}

    When("an action is performed (2)") {}

    Then("an outcome happens (3)") {}
  end

  def test_an_unfinished_example
    Given("a condition (1)") {}

    When("an action is performed (2)") {}

    Then("I need to keep writing the test (3)")
  end

  def test_with_another_language
    Dado("alguma coisa (1)") {}
    E("alguma coisa (2)") {}
    Quando("alguma coisa (3)") {}
    Entao("alguma coisa (4)") {}
    Mas("alguma coisa (5)") {}
  end

  Then("an outcome W2 happens (last)") { }

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
 Given a condition W (first)
       a condition (1)
  When an action is performed (2)
  Then an outcome happens (3)
       an outcome W2 happens (last)

")
  end

  it "test a_complex_example" do
    run_test 'test_a_complex_example'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_a_complex_example                                          PASS (0.00s)
 Given a condition W (first)
       a condition X (1)
   And a condition Y (2)
  When an action is performed (3)
  Then an outcome A happens (4)
       and an outcome B happens (5)
       an outcome W2 happens (last)

")
  end

  it "test an_unfinished_example" do
    run_test 'test_an_unfinished_example'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_an_unfinished_example                                      SKIP (0.00s)
 Given a condition W (first)
       a condition (1)
  When an action is performed (2)
  Then I need to keep writing the test (3)
       an outcome W2 happens (last)

")
  end

  it "test with_another_language" do
    run_test 'test_with_another_language'
    output = Bdd::Colors.clear(@reporter.io.string)

    expect(output).to eq ("TestAbc
  test_with_another_language                                      PASS (0.00s)
 Given a condition W (first)
  Dado alguma coisa (1)
     E alguma coisa (2)
Quando alguma coisa (3)
 Entao alguma coisa (4)
   Mas alguma coisa (5)
  Then an outcome W2 happens (last)

")
  end

end
