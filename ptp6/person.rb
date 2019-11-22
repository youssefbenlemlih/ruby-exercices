# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'
class Person
  include Consistency
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def stroke(pet)
    return false unless pet.is_a?(Pet)
    return pet.get_stroke(self) if pet.respond_to?(:get_stroke)
    false
  end

  def feed(pet)
    return false unless pet.is_a?(Pet)
    return pet.get_feed(self) if pet.respond_to?(:get_feed)
    false
  end

  def to_s
    "#{self.class}: name: #{@name} pets: #{@pets.map {|pet| pet.name}}"
  end

end
