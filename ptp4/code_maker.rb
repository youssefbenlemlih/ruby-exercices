class CodeMaker
  def initialize(symbol_count, code_length, is_human)
    @symbol_count = symbol_count
    @code_length = code_length
    @master_code = []
    @human = is_human
  end

  def unveil
    puts "Der Code war #{@master_code}"
  end

  def input_code
    code = []
    if @human
      print 'Bitte die Geheimkombination eingeben:'
      gets.chomp.split(/ ?/).each { |e| code << e.to_i }
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

  # @return [Hash] white => x, black => y
  def evaluate(code)
    hits = {white: white_hits(code), black: 0}
    code.each_with_index do |bit, pos|
      hits[:black] += 1 if black_hit?(bit, pos)
    end
    hits
  end

  # @return [Integer] Count of white hits
  def white_hits(code)
    hits = 0
    # Make a copy of master_code to be able to remove all black hits
    master_copy = []
    @master_code.each_with_index { |bit, i| master_copy[i] = black_hit?(code[i], i) ? nil : bit }
    code.each_with_index do |bit, i|
      next unless (mindex = master_copy.index(bit)) && !black_hit?(bit, i)

      # Remove bit at mindex so it won't be found again
      master_copy[mindex] = nil
      hits += 1
    end
    hits
  end

  # @return [Boolean]
  def black_hit?(bit, pos)
    @master_code[pos] == bit
  end
end