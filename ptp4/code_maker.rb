class CodeMaker
  def initialize(symbol_count,code_length)
    @symbol_count = symbol_count
    @code_length = code_length
    @master_code = []
  end

  def master_code!(code)
    @master_code = code
    nil
  end

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

  def code_feedback(code)
    return "Der code besteht nicht aus #{@code_length} Symbolen" if code.length != @code_length
    code.each do |e|
      if e < 1 || e > @symbol_count
        return "Der code beinhaltet unzulässige Symbole"
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