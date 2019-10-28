require_relative 'code_breaker'
require_relative 'code_maker'

class Mastermind
  def initialize
    @symbol_count = 6
    @code_length = 4
    @code_maker = CodeMaker.new(@symbol_count, @code_length)
    @code_breaker = CodeBreaker.new
    @rounds = 10
  end

  def start

    @rounds.times do
      puts @code_breaker.input_code
      puts @code_breaker.hits([1, 5, 6])
    end
  end

  def demand_mastercode
    puts 'Bitte die Geheimkombination eingeben'
    begin
      code = []
      gets.split.each { |e| code << e.to_i }
    end until @code_maker.code_feedback(code).nil?
    @code_maker.master_code!(code)
  end
end
