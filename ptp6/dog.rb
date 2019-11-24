# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative './pet'

# The class of Dogs
# Is a subclass of Pet
class Dog < Pet

  def initialize(name, birthday, person)
    super(name, birthday, 1)
    raise PetError, "A Dog's owner may only be a Person" unless person.is_a?(Person)

    @owner = person
    person.add_pet(self)
  end

  def to_s
    "#{super}, owner: #{@owner.name}"
  end
end