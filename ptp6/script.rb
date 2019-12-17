# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'date'
require_relative 'cat'
require_relative 'dog'
require_relative 'person'

begin
  hans = Person.new('hans')
  joe = Person.new('joe')
  bello = Dog.new('bello', Date.new(2019, 11, 19), hans)
  mike = Dog.new('mike', Date.new(2010, 11, 1), hans)
  tom = Cat.new("Tom", Date.new(2015, 02, 14), hans, joe)
  jerry = Cat.new("Jerry", Date.new(2015, 02, 14), joe)

  # puts tom.kill(mike)
  # puts tom.kill(jerry)
  # puts tom.kill(jerry)
  # puts mike.kill(bello)
  # puts mike.kill(tom)
  puts jerry.get_service(hans, :feed)
  puts jerry.get_service(joe, :feed)
rescue StandardError => e
  puts e.backtrace
  puts "'#{e.class}': " + e.message + "\n\n"
end

puts hans
puts joe
puts bello
puts mike
puts tom
puts jerry