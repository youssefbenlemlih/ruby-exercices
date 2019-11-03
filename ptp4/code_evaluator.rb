class CodeEvaluator
  def initialize
    @master_code = []
  end

  # @return [Hash] white => x, black => y
  def evaluate(mastercode, code)
    @master_code = mastercode
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

  # @return [Integer]
  def black_hits(mastercode, code)
    hits = 0
    code.each_with_index do |bit, i|
      hits += 1 if mastercode[i] == bit
    end
    hits
  end

  # @return [Boolean]
  def black_hit?(bit, pos)
    @master_code[pos] == bit
  end
end