class Person
  def initialize(*args)
    @person = OpenStruct.new(*args)
  end

  def [] proprety
    @person[proprety]
  end

  # sources https://ruby-doc.org/core-2.6.5/BasicObject.html#method-i-method_missing
  # https://www.leighhalliday.com/ruby-metaprogramming-method-missing
  def method_missing(method_name, *args, &block)
      @person.send(method_name, *args, &block)
  end

  def to_s
    @person.to_s
  end

end