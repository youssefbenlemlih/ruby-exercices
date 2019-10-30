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
    puts "\n #{@master_code}"
    hits = {white: 0, black: 0}
    locked = []
    code.each_with_index do |bit, pos|
      if black_hit?(bit, pos)
        hits[:black] += 1
        locked << pos
      end
    end
    code.each_with_index do |bit, pos|
      white_pos = white_hit_pos(code, bit, pos)
      if !white_pos.empty? && !(white_pos.all? { |wp| locked.include?(wp) })
        hits[:white] += 1
        locked.concat(white_pos)
      end
      puts "#{bit}: white=#{hits[:white]} #{locked}"
    end
    hits
  end

  def white_hit_pos(code, bit, pos)
    white_pos = []
    unless black_hit?(bit, pos)
      @master_code.each_with_index do |val, i|
        white_pos << i if val == bit && !black_hit?(code[i], i)
      end
    end
    white_pos
  end

  def black_hit?(bit, pos)
    @master_code[pos] == bit
  end
end