require 'test/unit'
require_relative 'code_maker'
require_relative 'mastermind'

class TestMastermind < Test::Unit::TestCase
  def setup
    @codemaker = CodeMaker.new(6, 4, false)
  end

  def test_codemaker
    @codemaker.master_code!([1, 2, 3, 4])
    assert_equal({white: 4, black: 0}, @codemaker.evaluate([2, 3, 4, 1]))
    assert_equal({white: 0, black: 1}, @codemaker.evaluate([1, 1, 1, 1]))
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([1, 4, 6, 1]))
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([2, 2, 2, 1]))
    assert_equal({white: 0, black: 2}, @codemaker.evaluate([1, 2, 2, 1]))
    assert_equal(1, @codemaker.white_hits([2, 2, 2, 1]))
    assert_equal(true, @codemaker.black_hit?(2, 1))
    assert_equal(false, @codemaker.black_hit?(1, 1))
    @codemaker.master_code!([1, 1, 2, 2])
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([1, 5, 5, 1]))
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([2, 2, 2, 5]))
    assert_equal({white: 0, black: 4}, @codemaker.evaluate([1, 1, 2, 2]))
    assert_equal({white: 0, black: 3}, @codemaker.evaluate([1, 2, 2, 2]))
  end

  def test_codebreaker
    guesses = 0
    repeat = 10
    repeat.times do
      @mastermind = Mastermind.new(6, 4, 10)
      @mastermind.start
      guesses += @mastermind.rounds_for_test
    end
    puts "Durchschnittlich benötigte Versuche: #{1.0 * guesses / repeat}"
  end
end