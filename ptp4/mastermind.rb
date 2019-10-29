require_relative 'code_breaker'
require_relative 'code_maker'

class Mastermind
  def initialize(symbol_count, code_length, rounds)
    @symbol_count = symbol_count
    @code_length = code_length
    @code_maker = CodeMaker.new(@symbol_count, @code_length)
    @code_breaker = CodeBreaker.new
    @rounds = rounds
  end

  def start
    @code_maker.master_code!(new_code(@code_maker))
    @rounds.times do |round|
      puts "\n#{round + 1}. Versuch"
      code = new_code(@code_breaker)
      hits = @code_maker.evaluate(code)
      @code_breaker.log(code, hits)
      @code_breaker.print_log
    end
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
