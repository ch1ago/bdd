$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'minitest/autorun'
require 'bdd/minitest'

Minitest::Reporters.use!(Minitest::Reporters::SpecReporter.new)

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
