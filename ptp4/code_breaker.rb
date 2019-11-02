class CodeBreaker
  def initialize(symbol_count, code_length, is_human)
    @symbol_count = symbol_count
    @code_length = code_length
    @human = is_human
    @log = []
    @code = []
    @excl_symbols = []
    @possible_codes = (1..@symbol_count).to_a.repeated_permutation(@code_length).to_a
  end

  def input_code
    if @human
      print 'Bitte gib deinen Tipp ab:'
      code = []
      gets.chomp.split(/ ?/).each { |e| code << e.to_i }
      @code = code
    else
      puts 'Ich denke...'
      sleep(1)
      @code = generate
    end
  end

  def new_hits(hits)
    log(hits)
    print_log
  end

  def log(hits)
    @log << {code: @code, hits: hits}
    nil
  end

  def print_log
    puts 'Nr | --- Codes --- | white hit | black hit |'
    @log.each_with_index do |row, i|
      code = row[:code].join(' | ')
      puts sprintf('%02d | %s |     %d     |     %d     |', i + 1, code, row[:hits][:white], row[:hits][:black])
    end
  end

  def generate
    puts @excl_symbols.to_s

    if @log.empty? || (@log.last[:hits][:white] == 0 && @log.last[:hits][:black] == 0)
      @excl_symbols.concat(@log.last[:code].uniq) unless @log.empty?
      return two_symbol_code(@code_length / 2, @code_length / 2)
    end
    (1..@code_length).map { pick_symbol }
  end

  def generate
    if @log.empty?
      # First try
      return two_symbol_code(@code_length / 2, @code_length / 2)
    else
      # delete last code guess from possible_codes
      @possible_codes.delete_if { |code| code == @log.last[:code] }
      s = possible_codes(@log.last[:code], @log.last[:hits][:black], @log.last[:hits][:white])

      return s[rand(0..s.length)]
    end
  end

  def possible_codes(guess, black, white)
    @possible_codes.select do |code|
      white_hits(guess, code) == white &&
        black_hits(guess, code) == black
    end
  end

  def minmax_algo
    all_answers = list_all_answers
    poss_count = @possible_codes.length
    @possible_codes.each do |code|
      delcount = []
      all_answers.each_with_index do |ans, i|
        delcount[i] = poss_count - possible_codes(code, ans[0], ans[1]).length
      end
    end
    # unfinished...
  end

  def list_all_answers
    # [black, white]
    [
      [0, 0], [0, 1], [0, 2], [0, 3], [0, 4],
      [1, 0], [1, 1], [1, 2], [1, 3],
      [2, 0], [2, 1], [2, 2],
      [3, 0],
      [4, 0]
    ]
  end

  def two_symbol_code(count1, count2)
    code = []
    s1 = pick_symbol
    begin
      s2 = pick_symbol
    end until s1 != s2
    count1.times { code << s1 }
    count2.times { code << s2 }
    code
  end

  def pick_symbol
    symbols = (1..@symbol_count).find_all { |e| !@excl_symbols.include?(e) }
    symbols[rand(0...symbols.length)]
  end

  # @return [Integer] Count of white hits
  def white_hits(mastercode, code)
    hits = 0
    # Make a copy of master_code to be able to remove all black hits
    master_copy = []
    mastercode.each_with_index { |bit, i| master_copy[i] = black_hit?(mastercode, code[i], i) ? nil : bit }
    code.each_with_index do |bit, i|
      next unless (mindex = master_copy.index(bit)) && !black_hit?(mastercode, bit, i)

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
  def black_hit?(mastercode, bit, pos)
    mastercode[pos] == bit
  end

  private
end