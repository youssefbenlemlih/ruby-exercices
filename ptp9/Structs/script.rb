# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'ostruct'
# require 'struct'
require 'json'
require_relative './person'

# setup Struct with parameters
p1 = OpenStruct.new(
    name: 'jan',
    age: 32,
    pet_name: 'tom',
    fax_number: '+123-456456')
# setup Struct a hash as one parameter
p2 = OpenStruct.new({
                        name: 'jan',
                        age: 32,
                        pet_name: 'tom',
                        fax_number: '+123-456456'})
# setup Struct with json file
p3 = nil
File.open('person.json') do |file|
  p3 = JSON.parse(file.read, object_class: OpenStruct)
end

p4 = Person.new(name: 'jan',
                age: 32,
                pet_name: 'tom',
                fax_number: '+123-456456')
# setup Struct with method names
Person2 = Struct.new(:name, :age)
p5 = Person2.new('jerry', 21)

puts p1
puts p2
puts p3
puts p4
puts p4.name
p4.name = 'KOKO'
puts p4.name
puts p5
puts p5.name

# puts p2 == p1
# puts p2 == p3
# puts p3 == p1