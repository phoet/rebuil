require 'test_helper'

class TestRebuil < Test::Unit::TestCase

  def re
    Rebuil::Expression.new
  end

  def test_characters
    assert_equal("[a]", re.characters("a").exp)
  end

  def test_characters_matches
    assert_match(re.group("an"), "anna")
    assert_match(re.group("na"), "anna")
  end

  def test_group
    assert_equal("(a)", re.group("a").exp)
  end

  def test_group_matches
    assert_match(re.group("uschi"), "uschi")
  end

  def test_group_with_characters
    exp = re.group{|exp| exp.characters("a")}.exp
    assert_equal("([a])", exp)
  end

  def test_group_with_instance_eval_and_characters
    exp = re.group{characters("a")}.exp
    assert_equal("([a])", exp)
  end
  
  def test_group_with_characters_matches
    exp = re.group{|exp| exp.characters("a")}
    assert_match(exp, "anna")
  end
  
  def test_group_with_match
    exp = rebuil.many.group('rebuil', :cool_name)
    assert_equal(exp.match('hello world with rebuil')[:cool_name], 'rebuil')
  end
  
  def test_rebuil_method
    assert_match(rebuil("uschi") << "sushi", "uschisushi")
  end
  
  def test_rebuil_method_with_block
    exp = rebuil{|rebuil| rebuil.group("uschi")}
    assert_match(re.group("uschi"), "uschi")
  end

  def test_line_start
    assert_match(re.line_start.group("an"), "anna")
    assert_no_match(re.line_start.group("na"), "anna")
  end
  
  def test_line_end
    assert_match(re.group("na").line_end, "anna")
    assert_no_match(re.group("an").line_end, "anna")
  end
  
  def test_line
    assert_match(re.line("anna"), "anna")
    assert_no_match(re.line("anna"), "anna ")
    assert_no_match(re.line("anna"), " anna")
  end
  
  def test_line_with_block
    assert_match(re.line{escape("anna")}, "anna")
  end
  
  def test_escape
    assert_match(re.escape(".[]*?+|( )^${}\A"), ".[]*?+|( )^${}\A")
    assert_equal(re.<<(".[]*?+|( )^${}\A").to_s,  Regexp.escape(".[]*?+|( )^${}\A"))
  end

  def test_to_r
    assert_equal(//i, re.to_r)
  end
  
  def test_multiline_regex_with_comments
    assert_match(%r[a # the a
                    n # the n
                    ]x, 'anna')
  end
  
  private
  
  # remove check for instance of regex-class, since there is no regex here!
  def assert_no_match(regexp, string, message="")
    _wrap_assertion do
      full_message = build_message(message, "<?> expected to not match\n<?>.", regexp, string)
      assert_block(full_message) { regexp !~ string }
    end
  end

end