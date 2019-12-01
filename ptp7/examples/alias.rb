# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# parent class with general info method and alias definitions
class Parent
  def info
    "info called from Parent!\n\tself: #{self.to_s}"
  end

  def self.set_aliases
    # calls info on self determined at runtime, can be used with symbols or strings
    alias_method :alias_method_info, 'info'
    # calls info on self at the time the source code is read (here: this class Parent)
    alias alias_info info
  end

end

# specifiying child class
class Child < Parent
  def info
    "info called from Child!\n\tself: #{self.to_s}"
  end

  set_aliases
end

puts "With alias_method:\n\t#{Child.new.alias_method_info}"
puts
puts "With alias:\n\t#{Child.new.alias_info}"