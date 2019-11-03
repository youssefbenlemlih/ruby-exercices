# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'code_evaluator'

# The CodeBreaker tries to guess the code
# in bot-mode, it makes use of the five-try-algorithm of Donald Knuth
# explanation reference: https://github.com/nattydredd/Mastermind-Five-Guess-Algorithm/blob/master/README.md
class CodeBreaker
  attr_reader :human

  def initialize(symbol_count, code_length, is_human)
    @symbol_count = symbol_count
    @code_length = code_length
    @human = is_human
    @log = []
    @code = []
    @possible_codes = (1..@symbol_count).to_a.repeated_permutation(@code_length).to_a
    @all_codes = @possible_codes
    @evaluator = CodeEvaluator.new
  end

  # Returns a code guess
  # if @human will ask the user otherwise will use the five guess algorithm
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

  # adds the new hits to the log
  def new_hits(hits)
    @log << {code: @code, hits: hits}
    nil
  end

  # Generates a code guess based on the five guess algorithm
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

  # returns an array containing all possible that have the same evaluation as the guess_master
  def possible_codes(guess_master, black, white)
    @possible_codes.select do |code|
      hits = @evaluator.evaluate(guess_master, code)
      hits[:white] == white && hits[:black] == black
    end
  end

  # the Min-Max-Algorithm
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

  # all possible black and white combinations
  def list_all_answers
    # [black, white]
    answers = []
    (@code_length + 1).times do |b|
      (@code_length + 1).times do |w|
        answers << [b, w] if (b + w <= @code_length && !(w == 1 && b == (@code_length - 1)))
      end
    end
    answers
  end

  # returns a code where the first half of elements are the same symbol as well as the second half
  def two_symbol_code(count)
    code = []
    count1 = count / 2
    count2 = count.even? ? count / 2 : count / 2 + 1
    s1 = rand(1..@symbol_count)
    begin
      s2 = rand(1..@symbol_count)
    end until s1 != s2
    count1.times { code << s1 }
    count2.times { code << s2 }
    code
  end

end