# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'
class PersonError < StandardError;
end
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
    raise PersonError, 'A person can only stroke a Pet' unless pet.is_a?(Pet)

    pet.get_stroke(self) if pet.respond_to?(:get_stroke)
  end

  def feed(pet)
    raise PersonError, 'A person can only feed a Pet' unless pet.is_a?(Pet)

    pet.get_feed(self) if pet.respond_to?(:get_feed)
  end

  def to_s
    "#{self.class}: name: #{@name} pets: #{@pets.map { |pet| pet.name }}"
  end

end
