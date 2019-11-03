# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'code_evaluator'
# represents a Codemaker in th Game Mastermind
class CodeMaker
  attr_reader :human

  # Recieves the Game config parameters
  def initialize(symbol_count, code_length, is_human)
    @symbol_count = symbol_count
    @code_length = code_length
    @master_code = []
    @human = is_human
    @evaluator = CodeEvaluator.new
  end

  # gives an evaluation (black and white hits) to the given code
  def evaluate(guess)
    @evaluator.evaluate(@master_code, guess)
  end

  # Reviels the code (console output)
  def unveil
    puts "Der Code war #{@master_code}"
  end

  # Returns a code
  # Asks the user if not human otherwise generates a random combination
  def input_code
    code = []
    if @human
      print 'Bitte die Geheimkombination eingeben:'
      gets.chomp.split(/ ?/).each { |e| code << e.to_i }
      50.times { puts "\n" }
    else
      puts 'Geheimkombination wird generiert...'
      @code_length.times { code << rand(1..@symbol_count) }
    end
    code
  end

  # sets the mastercode
  def master_code!(code)
    @master_code = code
    nil
  end

  # @return [String,NilClass] String if invalid code, nil if the code is valid
  def invalid_code_msg(code)
    return "Der Code besteht nicht aus #{@code_length} Symbolen" if code.length != @code_length

    code.each do |e|
      if e < 1 || e > @symbol_count
        return 'Der Code beinhaltet unerlaubte Symbole'
      end
    end
    nil
  end

end