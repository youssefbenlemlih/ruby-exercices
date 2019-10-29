class CodeBreaker
  def initialize
    @log = []
    @human = true
  end

  def input_code
    if @human
      print 'Bitte gib deinen Tipp ab:'
      code = []
      gets.chomp.split('').each { |e| code << e.to_i }
      code
    end
  end

  def log(code, hits)
    @log << {code: code, hits: hits}
    nil
  end

  def print_log
    puts 'Nr | --- Codes --- | white hit | black hit |'
    @log.each_with_index do |row, i|
      code = row[:code].join(' | ')
      puts sprintf('%d. | %s |     %d     |     %d     |', i + 1, code, row[:hits][:white], row[:hits][:black] )
    end
  end

  private
end