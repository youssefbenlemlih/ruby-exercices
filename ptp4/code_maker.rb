class CodeMaker
  def initialize
    @symbol_count = 6
    @code_length = 4
    @master_code = []
  end

  def master_code!(code)
    validate_code(code)
    @master_code = code
    nil
  end

  def evaluate(code)
    validate_code(code)
    hits = {:white => 0, :black => 0}
    code.each_with_index do |bit, i|
      hits[:black] += 1 if black_hit?(bit, i)
    end
    code.uniq.each_with_index do |bit, i|
      hits[:white] += 1 if white_hit?(bit, i)
    end
    hits
  end

  def validate_code(code)
    raise ArgumentError, "Der code besteht nicht aus #{@code_length} Symbolen" if code.length != @code_length
    contains_forbidden = false
    code.each do |e|
      if e < 1 || e > @symbol_count
        contains_forbidden = true
      end
    end
    raise ArgumentError, "Der code beinhaltet unzulässige Symbole" if contains_forbidden
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