# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'

# A subclass of StandardError to manage not allowed Person operations
class PersonError < StandardError;
end
# The class of Person
# A person has a name and pets
class Person
  include Consistency
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  # Adds a pet to the person
  def add_pet(pet)
    @pets << pet
  end

  # gives a service to the given Pet
  # @param [Pet] pet the pet to receive the service
  # @param [Symbol] service Either :feed of :stroke
  def give_service(pet, service)
    raise PersonError, 'A person can only stroke or feed a Pet' unless pet.is_a?(Pet)

    pet.get_service(self, service)
  end

  def to_s
    "#{self.class}: name: #{@name} pets: #{@pets.map(&:name)}"
  end

end
