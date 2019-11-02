require_relative 'code_breaker'
require_relative 'code_maker'

class Mastermind
  attr_reader :rounds_for_test
  def initialize(symbol_count, code_length, rounds)
    @symbol_count = symbol_count
    @code_length = code_length
    @code_maker = CodeMaker.new(@symbol_count, @code_length, false)
    @code_breaker = CodeBreaker.new(@symbol_count, @code_length, false)
    @rounds = rounds
    @rounds_for_test = 0
  end

  def start
    @code_maker.master_code!(new_code(@code_maker))
    hits = Hash.new
    @rounds.times do |round|
      @rounds_for_test += 1
      puts "\n#{round + 1}. Versuch"
      code = new_code(@code_breaker)
      hits = @code_maker.evaluate(code)
      @code_breaker.new_hits(hits)
      break if hits[:black] == @code_length
    end
    stop(hits[:black])
  end

  def stop(blackhits)
    puts 'Das Spiel wurde beendet. Auswertung folgt...'
    puts "Der #{ blackhits == @code_length ? "CodeBreaker" : "CodeMaker"} hat gewonnen!"
    @code_maker.unveil
  end

  def new_code(person)
    code = []
    loop do
      code = person.input_code
      inval_code = @code_maker.invalid_code_msg(code)
      break if inval_code.nil?

      puts inval_code
    end
    code
  end

end
