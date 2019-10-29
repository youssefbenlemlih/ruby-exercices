require 'test/unit'
require_relative 'code_maker'

class TestMastermind < Test::Unit::TestCase
  def setup
    @codemaker = CodeMaker.new(6,4)
  end

  def test_codemaker
    @codemaker.master_code!([1, 2, 3, 4])
    assert_equal({white: 4, black: 0}, @codemaker.evaluate([2, 3, 4, 1]))
    assert_equal({white: 0, black: 1}, @codemaker.evaluate([1, 1, 1, 1]))
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([1, 4, 6, 1]))
    code_tip = [2, 2, 2, 1]
    assert_equal([0], @codemaker.white_hit_pos(code_tip, 1, 3))
    assert_equal([], @codemaker.white_hit_pos(code_tip, 5, 0))
    assert_equal(true, @codemaker.black_hit?(2, 1))
    assert_equal(false, @codemaker.black_hit?(1, 1))
    @codemaker.master_code!([1, 1, 2, 2])
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([1, 5, 5, 1]))
    assert_equal({white: 2, black: 0}, @codemaker.evaluate([2, 2, 5, 5]))
  end
end