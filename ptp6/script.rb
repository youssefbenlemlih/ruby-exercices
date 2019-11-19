require 'date'
require_relative 'cat'
require_relative 'pet'
require_relative 'dog'
require_relative 'person'

hans = Person.new('hans')
joe = Person.new('joe')
bello = Dog.new('bello', Date.new(2019,11,19), hans)
mike = Dog.new('mike', Date.new(2010,11,1), hans)
tom = Cat.new("Tom", Date.new(2015,02,14), hans, joe)
jerry = Cat.new("Jerry", Date.new(2015,02,14), hans, joe)
tom.kill(mike)
tom.kill(jerry)
mike.kill(bello)
mike.kill(tom)
puts hans
puts joe
puts bello
puts mike
puts tom
puts jerry
