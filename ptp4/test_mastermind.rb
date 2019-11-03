# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'test/unit'
require_relative 'code_maker'
require_relative 'mastermind'
require_relative 'code_evaluator'

class TestMastermind < Test::Unit::TestCase
  def setup
    @codemaker = CodeMaker.new(6, 4, false)
    @evaluator = CodeEvaluator.new
  end

  def test_codemaker
    @codemaker.master_code!([1, 2, 3, 4])
    assert_equal({white: 4, black: 0}, @codemaker.evaluate([2, 3, 4, 1]))
    assert_equal({white: 0, black: 1}, @codemaker.evaluate([1, 1, 1, 1]))
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([1, 4, 6, 1]))
    assert_equal({white: 1, black: 1}, @codemaker.evaluate([2, 2, 2, 1]))
    assert_equal({white: 0, black: 2}, @codemaker.evaluate([1, 2, 2, 1]))

    assert_equal({white: 1, black: 1}, @evaluator.evaluate([1, 1, 2, 2], [1, 5, 5, 1]))
    assert_equal({white: 1, black: 1}, @evaluator.evaluate([1, 1, 2, 2], [2, 2, 2, 5]))
    assert_equal({white: 0, black: 4}, @evaluator.evaluate([1, 1, 2, 2], [1, 1, 2, 2]))
    assert_equal({white: 0, black: 3}, @evaluator.evaluate([1, 1, 2, 2], [1, 2, 2, 2]))
  end

  def test_codebreaker
    guesses = 0
    repeat = 10
    config = {
        'symbol_count' => 6,
        'code_length' => 4,
        'max_rounds' => 10,
        'codemaker_is_human' => false,
        'codebreaker_is_human' => false
    }
    repeat.times do
      @mastermind = Mastermind.new(config)
      @mastermind.start
      guesses += @mastermind.rounds_for_test
    end
    puts "Durchschnittlich benötigte Versuche: #{1.0 * guesses / repeat}"
  end
end