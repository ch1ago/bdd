require 'spec_helper'
require 'bdd/colors'
require 'bdd/minitest'

class Meme
  def i_can_has_cheezburger?
    "OHAI!"
  end

  def will_it_blend?
    "DONT BLEND KITTY!"
  end
end

class TestMeme < Minitest::Spec
  def setup
    @meme = Meme.new
  end

  def test_that_kitty_can_eat
    Given 'a meme' do
    end

    When 'I wanz cheezburger' do
    end

    Then 'I can haz cheezburger' do
      assert_equal "OHAI!", @meme.i_can_has_cheezburger?
    end
  end

  def test_that_kitty_will_blend
    When 'I want to blend kitty' do
      assert_equal "OHAI!", @meme.will_it_blend?
    end

    Then 'I can blend kitty' do
    end
  end
end


describe Minitest::Reporters::SpecReporter do
  before do
    @test = TestMeme.new('')
    @reporter = Minitest::Reporters::SpecReporter.new
    @reporter.io = StringIO.new
    Minitest::Reporters.use!(@reporter)
  end

  def run_test(name)
    @test.name = name
    @test.run
    @reporter.record(@test)
  end

  it "test_that_kitty_can_eat" do
    run_test 'test_that_kitty_can_eat'

    output = Bdd::Colors.remove_color(@reporter.io.string)
    expect(output).to include('test_that_kitty_can_eat')
    expect(output).to include('PASS')
    expect(output).to include('Given a meme')
    expect(output).to include('When I wanz cheezburger')
    expect(output).to include('Then I can haz cheezburger')
    expect(@test.assertions).to eq(1)
    expect(@test.failures.count).to eq(0)
  end

  it "test_that_kitty_will_blend" do
    run_test 'test_that_kitty_will_blend'

    output = Bdd::Colors.remove_color(@reporter.io.string)
    expect(output).to include('test_that_kitty_will_blend')
    expect(output).to include('FAIL')
    expect(output).to include('When I want to blend kitty')
    expect(output).not_to include('Then')
    expect(output).to include('Expected: "OHAI!"')
    expect(output).to include('Actual: "DONT BLEND KITTY!"')

    expect(@test.assertions).to eq(1)
    expect(@test.failures.count).to eq(1)
  end

end
