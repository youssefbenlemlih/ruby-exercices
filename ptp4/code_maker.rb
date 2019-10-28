class CodeMaker
  def initialize
    @symbol_count = 6
    @code_length = 4
    @master_code = []
  end

  def master_code!(code)
    @master_code = code
  end

  def evaluate(code)
    @hits = {:white => 0, :black => 0}
    code.each_with_index do |bit, i|
      @hits[:black] += 1 if black_hit?(bit, i)
    end
    code.uniq.each_with_index do |bit, i|
      @hits[:white] += 1 if white_hit?(bit, i)
    end
    hits
  end

  private

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