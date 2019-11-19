# Author:: YB
class K
  def self.create_func(a,b)
    self.method(:f).curry.call(a,b)
  end
  private
  def self.f(a,b,x)
    a*x+b
  end
end

class A
  def initialize(*a)
    p a
    p a.to_a.compact
    puts a.class
  end
end

#A.new()
funcs ={}
name = gets
a = gets.to_i
b = gets.to_i
funcs[name] = K.create_func(a,b)

# puts times2 =
# puts times2.call(2)