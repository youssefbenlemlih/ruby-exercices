require 'test/unit'
require_relative 'code_maker'

class TestMastermind < Test::Unit::TestCase
  def setup
    @codemaker = CodeMaker.new
  end

  def test_codemaker
    @codemaker.master_code!([1, 2, 3, 4])
    assert_equal({:white => 4, :black => 0}, @codemaker.evaluate([2, 3, 4, 1]))
    assert_equal({:white => 0, :black => 1}, @codemaker.evaluate([1, 1, 1, 1]))
    assert_equal({:white => 1, :black => 1}, @codemaker.evaluate([1, 4, 6, 1]))
    assert_equal(true, @codemaker.white_hit?(1, 1))
    assert_equal(false, @codemaker.white_hit?(5, 1))
    assert_equal(true, @codemaker.black_hit?(2, 1))
    assert_equal(false, @codemaker.black_hit?(1, 1))
    assert_raise(ArgumentError,@codemaker.validate_code([5]))
  end
end