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

  def give_service(pet, service)
    raise PersonError, 'A person can only stroke or feed a Pet' unless pet.is_a?(Pet)

    pet.get_service(self, service)
  end

  def to_s
    "#{self.class}: name: #{@name} pets: #{@pets.map { |pet| pet.name }}"
  end

end
