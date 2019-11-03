# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'code_breaker'
require_relative 'code_maker'

class Mastermind
  attr_reader :rounds_for_test

  def initialize(config)
    @symbol_count = config['symbol_count']
    @code_length = config['code_length']
    @code_maker = CodeMaker.new(@symbol_count, @code_length, config['codemaker_is_human'])
    @code_breaker = CodeBreaker.new(@symbol_count, @code_length, config['codebreaker_is_human'])
    @max_rounds = config['max_rounds']
    @log = []
    @rounds_for_test = 0
  end

  def start
    puts 'Es geht los!'
    puts "Codemaker: #{@code_maker.human ? 'Mensch' : 'Computer'}"
    puts "Codebreaker: #{@code_breaker.human ? 'Mensch' : 'Computer'}\n"
    @code_maker.master_code!(new_code(@code_maker))
    hits = {}
    @max_rounds.times do |round|
      @rounds_for_test += 1
      puts "\n#{round + 1}. Versuch"
      code = new_code(@code_breaker)
      hits = @code_maker.evaluate(code)
      @code_breaker.new_hits(hits)
      new_hits(code, hits)
      print_log
      break if hits[:black] == @code_length
    end
    stop(hits[:black])
  end

  def new_hits(code, hits)
    @log << {code: code, hits: hits}
    nil
  end

  def print_log
    puts "Nr | Codes #{"-" * (@code_length * 4 - 9)} | white hit | black hit |"
    count = @max_rounds
    @max_rounds.times do
      count -= 1
      if count >= @log.length
        puts "#{sprintf('%02d', count+1)} |#{"   |" * (@code_length)}           |           |"
      else
        row = @log[count]
        code = row[:code].join(' | ')
        puts sprintf('%02d | %s |     %d     |     %d     |', count + 1, code, row[:hits][:white], row[:hits][:black])
      end
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

  def stop(blackhits)
    puts 'Das Spiel wurde beendet. Auswertung folgt...'
    puts "Der #{ blackhits == @code_length ? 'CodeBreaker' : 'CodeMaker'} hat gewonnen!"
    @code_maker.unveil
  end

end
