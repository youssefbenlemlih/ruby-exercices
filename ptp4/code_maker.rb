class CodeMaker
  def initialize(symbol_count, code_length)
    @symbol_count = symbol_count
    @code_length = code_length
    @master_code = []
    @human = true
  end

  def input_code
    code = []
    if @human
      print 'Bitte die Geheimkombination eingeben:'
      gets.chomp.split('').each { |e| code << e.to_i }
    else
      puts 'Geheimkombination wird generiert...'
      @code_length.times { code << rand(1..@symbol_count) }
    end
    code
  end

  def master_code!(code)
    @master_code = code
    nil
  end

  # @return [Hash] white => x, black => y
  def evaluate(code)
    hits = {:white => 0, :black => 0}
    code.each_with_index do |bit, i|
      hits[:black] += 1 if black_hit?(bit, i)
    end
    code.uniq.each_with_index do |bit, i|
      hits[:white] += 1 if white_hit?(bit, i)
    end
    hits
  end

  def invalid_code_msg(code)
    return "Der Code besteht nicht aus #{@code_length} Symbolen" if code.length != @code_length

    code.each do |e|
      if e < 1 || e > @symbol_count
        return 'Der Code beinhaltet unerlaubte Symbole'
      end
    end
    nil
  end

  def white_hit?(bit, pos)
    if !black_hit?(bit, pos)
      @master_code.include?(bit)
    else
      false
    end
  end

  def black_hit?(bit, pos)
    @master_code[pos] == bit
  end
end