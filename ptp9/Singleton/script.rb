# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require('singleton')

# A simple class that prints every time that a single method is added to it
class Clazz
  attr_reader :name

  def Clazz.singleton_method_added(id)
    puts "Adding #{id} to Clazz"
  end

  def initialize(name)
    @name = name
  end

  # third way to add a singleton method
  def self.third_singleton_method
    puts 'third_singleton_method'
  end
end

# A basic singleton class
class ClazzSingelton
  include Singleton
  attr_reader :name
end
a = Clazz.new('tom')

# first way to add a singleton method
a.define_singleton_method(:my_singleton_method) do
  puts 'the singleton method'
end
# second way to add a singleton method
def Clazz.second_singleton_method
  puts 'second singleton method'
end

# singleton adn singleton2 point to the same singleton instance
singleton = ClazzSingelton.instance
singleton2 = ClazzSingelton.instance
puts "singleton.equal?(singleton2)=#{singleton.equal?(singleton2)}"
# singleton_class returns the same instance

b = a.singleton_class
c = a.singleton_class
puts "c.equal?(b)=#{c.equal?(b)}"
a.my_singleton_method