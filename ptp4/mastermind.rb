require_relative 'code_breaker'
require_relative 'code_maker'

class Mastermind
  def initialize(symbol_count, code_length, rounds)
    @symbol_count = symbol_count
    @code_length = code_length
    @code_maker = CodeMaker.new(@symbol_count, @code_length)
    @code_breaker = CodeBreaker.new
    @rounds = rounds
    @log = []
  end

  def start
    @code_maker.master_code!(new_code(@code_maker))
    hits = Hash.new
    @rounds.times do |round|
      puts "\n#{round + 1}. Versuch"
      code = new_code(@code_breaker)
      hits = @code_maker.evaluate(code)
      log(code, hits)
      print_log
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

  def log(code, hits)
    @log << {code: code, hits: hits}
    nil
  end

  def print_log
    puts 'Nr | --- Codes --- | white hit | black hit |'
    @log.each_with_index do |row, i|
      code = row[:code].join(' | ')
      puts sprintf('%d. | %s |     %d     |     %d     |', i + 1, code, row[:hits][:white], row[:hits][:black] )
    end
  end

end
