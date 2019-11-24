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
    @personal = persons
    persons.each do |p|
      if p.is_a?(Person)
        p.add_pet(self)
      else
        throw PetError, "A cat's personal may only include persons"
      end
    end
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


  def to_s
    "#{super}, personal: #{@personal.map { |p| p.name }}"
  end
end
