class CodeBreaker
  def initialize(symbol_count, code_length, is_human)
    @symbol_count = symbol_count
    @code_length = code_length
    @human = is_human
    @log = []
    @code = []
    @excl_symbols = []
  end

  def input_code
    if @human
      print 'Bitte gib deinen Tipp ab:'
      code = []
      gets.chomp.split(/ ?/).each { |e| code << e.to_i }
      @code = code
    else
      puts("Ich denke...")
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
      puts sprintf('%d. | %s |     %d     |     %d     |', i + 1, code, row[:hits][:white], row[:hits][:black])
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

  private
end