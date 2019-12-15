# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require('singleton')

class Clazz
  attr_reader :name

  def Clazz.singleton_method_added(id)
    puts "Adding #{id} to Clazz"
  end

  def initialize(name)
    @name = name
  end

  def self.third_singleton_method
    puts 'third_singleton_method'
  end
end

class ClazzSingelton
  include Singleton
  attr_reader :name
end

a = Clazz.new('tom')
a2 = Clazz.new('tom2')
a.define_singleton_method(:my_singleton_method) do
  puts 'the singleton method'
end

def Clazz.second_singleton_method
  puts 'second singleton method'
end

b = a.singleton_class
c = a2.singleton_class
singleton = ClazzSingelton.instance
singleton2 = ClazzSingelton.instance
puts singleton
puts singleton2
puts a.inspect
puts b.inspect
puts c.inspect
puts c.name
puts a == b
puts c == b
a.my_singleton_method

# a2.my_singleton_method # doesnt work
# b.my_singleton_method # doesnt work

#basicObject = BasicObject.new
#puts "basicObject=>#{basicObject.class}"
#basicObjectSingleton = basicObject.singleton_class
#puts "basicObjectSingleton=>#{basicObjectSingleton.class}"
