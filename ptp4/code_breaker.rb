class CodeBreaker
  def initialize
    @hits_history = []
  end

  def input_code
    puts "Please Insert a code"
    code = []
    gets.split.each { |e| code << e.to_i }
    code
  end

  def hits(hits)
    puts "The hits for your move #{hits}"
  end

  private
end