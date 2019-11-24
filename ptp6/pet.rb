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

    if service == :feed
      return false unless person.respond_to?(:feed)
      person.feed(self)

    elsif service == :stroke
      return false unless person.respond_to?(:stroke)
      person.stroke(self)

    end
  end

  # @param [Person] stoker
  def get_stroke(stoker)
    unless stoker.is_a?(Person)
      raise PetError, 'A pet can only be stroked by a person'
    end

    puts "I (#{name}) am getting stroked by #{stoker.name}"
  end

  def get_feed(feeder)
    unless feeder.is_a?(Person)
      raise PetError, 'A pet can only be fed by a person'
    end

    puts "I (#{name}) am being fed by #{feeder.name}"
    true
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
