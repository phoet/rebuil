require 'test_helper'
require 'rebuil'

class TestRebuil < Test::Unit::TestCase

  def setup
    @rebuil = Rebuil::Expression.new
  end

  def test_characters
    assert_equal("[a]", @rebuil.characters("a").exp)
  end

  def test_characters_matches
    assert_match(@rebuil.group("an").to_r, "anna")
  end

  def test_group
    assert_equal("(a)", @rebuil.group("a").exp)
  end

  def test_group_matches
    assert_match(@rebuil.group("uschi").to_r, "uschi")
  end

  def test_group_with_characters
    exp = @rebuil.group{|exp| exp.characters("a")}.exp
    assert_equal("([a])", exp)
  end

  def test_group_with_characters_matches
    exp = @rebuil.group{|exp| exp.characters("a")}.to_r
    assert_match(exp, "anna")
  end

  def test_rebuil_method
    exp = rebuil{|rebuil| rebuil.group("uschi")}
    assert_match(@rebuil.group("uschi").to_r, "uschi")
  end

  def test_to_r
    assert_equal(//, @rebuil.to_r)
  end

end