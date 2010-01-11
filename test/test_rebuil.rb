require 'test_helper'
require 'rebuil'

class TestRebuil < Test::Unit::TestCase

  def setup
    @rebuil = Rebuil::Expression.new
  end

  def test_group
    assert_equal("(a)", @rebuil.group("a").exp)
  end
  
end