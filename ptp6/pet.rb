# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'

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

  def request_stroke(person)
    return false unless person.respond_to?(:stroke)
    person.stroke(self)
  end

  def request_feed(person)
    return false unless person.respond_to?(:feed)
    person.feed(self)
  end

  def stroke(stroker)
    return false unless stroker.is_a?(Person)
    true
  end

  def feed(feeder)
    return false unless feeder.is_a?(Person)
    true
  end

  def to_s
    "#{self.class}: name: #{@name}, birthday: #{@birthday}, lifes: #{@lifes}, alive: #{@alive} #{self.special_to_s}"
  end

  # TODO: Maybe rather raise an exception than returning false..?
  def kill(other)
    return false if !self.is_a?(Cat) && other.is_a?(Cat)
    return false if self == other
    return false unless other.alive
    other.die
  end

  protected

  def die
    @lifes -= 1
    @alive = @lifes != 0
  end
end