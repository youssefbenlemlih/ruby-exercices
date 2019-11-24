# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative './pet'

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

  def get_stroke(stroker)
    return false unless @personal.include?(stroker)
    true
  end

  def get_feed(feeder)
    false unless @personal.include?(feeder)
    true
  end

  def special_to_s
    "personal: #{@personal.map { |p| p.name }}"
  end
end
