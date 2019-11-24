# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'

# A subclass of [StandardError] to manage not allowed pet operations
class PetError < StandardError
end

# The class of Pets
# A pet has a a name, a birthday, and a number of lifes
class Pet
  include Consistency
  attr_reader :name, :alive
  protected :alive

  def initialize(name, birthday, lifes)
    @name = name
    @birthday = birthday
    @lifes = lifes
    @alive = true
  end

  # Requests a service from the given Person
  # @param [Person] person The person who will give the service
  # @param [Symbol] service Either :feed of :stroke
  def request_service(person, service)
    raise PetError, 'A pet can only request a service from a Person' unless person.is_a?(Person)

    person.give_service(self, service)
  end

  # Receives the service from the given Person
  # @param [Person] giver the Person who gives the service
  # @param [Symbol] service Either :feed of :stroke
  def get_service(giver, service)
    unless giver.is_a?(Person)
      raise PetError, 'A pet can only get a service from a Person'
    end

    if service == :stroke
      puts "I (#{name}) am getting stroked by #{giver.name}"
    elsif service == :feed
      puts "I (#{name}) am getting fed by #{giver.name}"
    else
      raise PetError, "A Pet cannot receive the service '#{service}'"
    end
  end

  def to_s
    "#{self.class}: name: #{@name}, birthday: #{@birthday}, lifes: #{@lifes}, alive: #{@alive} #{special_to_s}"
  end

  def special_to_s
    ''
  end

  # @param [Pet] other The victim
  def kill(other)
    if !is_a?(Cat) && other.is_a?(Cat)
      raise CatError, 'Only a cat can kill another Cat.'
    end

    raise CatError, 'A Cat cannot kill himself.' if self == other && is_a?(Cat)

    unless other.alive
      raise PetError, "Cannot kill #{other.name} as it is already dead."
    end

    other.die
  end

  protected

  # Reduces the lifes by one
  #  Checks if @alive
  def die
    @lifes -= 1
    @alive = @lifes != 0
    puts "I (#{name}) am now dead" unless @alive
  end

end
