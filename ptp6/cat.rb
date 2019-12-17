# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative './pet'

# A subclass of StandardError to manage not allowed Cat operations
class CatError < StandardError;
end

# The class of Cats
# Is a subclass of Pet
class Cat < Pet

  def initialize(name, birthday, *persons)
    super(name, birthday, 9)
    @personal = []
    persons.each { |person| add_personal(person) }
  end

  def add_personal(person)
    @personal << person
    if person.is_a?(Person)
      person.add_pet(self)
    else
      raise PetError, "A cat's personal may only include persons"
    end
    self
  end

  def remove_personal(person)
    person.remove_pet(self)
    @personal.delete(person)
  end

  def get_service(giver, service)
    unless @personal.include?(giver)
      raise CatError, 'A Cat can only receive a receive from his own Personal'
    end

    super(giver, service)
  end

  def kill(other)
    raise CatError, 'A Cat cannot kill himself.' if self == other

    super(other)
  end

  def die(killer)
    raise CatError, 'Only a cat can kill another Cat.' unless killer.is_a?(Cat)
    super(killer)
  end

  def to_s
    "#{super}, personal: #{@personal.map { |p| p.name }}"
  end
end
