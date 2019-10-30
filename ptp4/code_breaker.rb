class CodeBreaker
  def initialize
    @human = true
  end

  def input_code
    if @human
      print 'Bitte gib deinen Tipp ab:'
      code = []
      gets.chomp.split(/ ?/).each { |e| code << e.to_i }
      code
    end
  end



  private
end