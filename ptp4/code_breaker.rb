# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'code_evaluator'

# The CodeBreaker tries to guess the code
# in bot-mode, it makes use of the five-try-algorithm of Donald Knuth
# explanation reference: https://github.com/nattydredd/Mastermind-Five-Guess-Algorithm
class CodeBreaker
  attr_reader :human

  def initialize(symbol_count, code_length, is_human)
    @symbol_count = symbol_count
    @code_length = code_length
    @human = is_human
    @log = []
    @code = []
    @excl_symbols = []
    @possible_codes = (1..@symbol_count).to_a.repeated_permutation(@code_length).to_a
    @all_codes = @possible_codes
    @evaluator = CodeEvaluator.new
  end

  def input_code
    if @human
      print 'Bitte gib deinen Tipp ab:'
      code = []
      gets.chomp.split(/ ?/).each { |e| code << e.to_i }
      @code = code
    else
      puts 'Ich denke...'
      sleep(0.5)
      @code = generate
    end
  end

  def new_hits(hits)
    @log << {code: @code, hits: hits}
    nil
  end

  def generate
    if @log.empty?
      # First try
      two_symbol_code(@code_length)
    else
      # delete last code guess from possible_codes
      @possible_codes.delete_if { |code| code == @log.last[:code] }
      s = possible_codes(@log.last[:code], @log.last[:hits][:black], @log.last[:hits][:white])
      # remove all codes that would not give the same response if the last code guess weren't the mastercode
      @possible_codes.delete_if { |code| !s.include?(code) }
      minmax_algo
    end
  end

  def possible_codes(guess_master, black, white)
    @possible_codes.select do |code|
      hits = @evaluator.evaluate(guess_master, code)
      hits[:white] == white && hits[:black] == black
    end
  end

  def minmax_algo
    all_answers = list_all_answers
    codes_count = @all_codes.length
    max_delcount = {}
    @all_codes.each do |code|
      delcount = []
      all_answers.each_with_index do |ans, i|
        # count of codes that would be deleted with the current answer (black/white)
        delcount[i] = codes_count - possible_codes(code, ans[0], ans[1]).length
      end
      # store maximum delcount for each possible code
      max_delcount[code] = delcount.max
    end
    minmax_delcount = max_delcount.values.min
    !max_delcount.key(minmax_delcount).nil? ? max_delcount.key(minmax_delcount) : two_symbol_code(@code_length)
  end

  def list_all_answers
    # [black, white]
    [
        [0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
        [1, 0], [1, 1], [1, 2], [1, 3],
        [2, 0], [2, 1], [2, 2],
        [3, 0],
        [4, 0]
    ]
  end

  def two_symbol_code(count)
    code = []
    count1 = count / 2
    count2 = count.even? ? count / 2 : count / 2 + 1
    s1 = pick_symbol
    begin
      s2 = pick_symbol
    end until s1 != s2
    count1.times { code << s1 }
    count2.times { code << s2 }
    code
  end

  def pick_symbol
    symbols = (1..@symbol_count).find_all { |e| !@excl_symbols.include?(e) }
    symbols[rand(0...symbols.length)]
  end

end