class Example

  attr_writer :test

  def output
    p @bnbm
  end
end

# example = Example.new
# example.output
# example.test = "Hallo"

:sym #= #{1+1}

# puts :var =>  :"#{1+1}"

var = :"a#{1+1}"
puts var.inspect