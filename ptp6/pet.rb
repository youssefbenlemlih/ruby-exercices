# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'
class PetError < StandardError
end
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

  def request_service(person, service)
    raise PetError, "A pet can only request a service from a Person" unless person.is_a?(Person)

    person.give_service(self, service)
  end

  def get_service(giver, service)
    unless giver.is_a?(Person)
      raise PetError, 'A pet can only get a service from a Person'
    end
    if service == :stroke
      puts "I (#{name}) am getting stroked by #{giver.name}"
    elsif service == :feed
      puts "I (#{name}) am getting fed by #{giver.name}"
    else
      raise PetError, "A Pet cannot recieve the service '#{service}'"
    end
  end

  def to_s
    "#{self.class}: name: #{@name}, birthday: #{@birthday}, lifes: #{@lifes}, alive: #{@alive} #{self.special_to_s}"
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

  def die
    @lifes -= 1
    @alive = @lifes != 0
    puts "I (#{name}) am now dead" unless @alive
  end

end
