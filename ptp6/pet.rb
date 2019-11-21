# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'

class Pet
  include Consistency
  attr_reader :name

  def initialize(name, birthday,lifes)
    @name = name
    @birthday = birthday
    @lifes = lifes
    @alive = true
  end

  def to_s
    "#{self.class}: name: #{@name}, birthday: #{@birthday}, lifes: #{@lifes}, alive: #{@alive} #{self.special_to_s}"
  end

  def kill(other)
    return false if !self.is_a?(Cat) && other.is_a?(Cat)
    return false if self == other
    other.die
  end

  protected

  def die
    if @alive
      @lifes -= 1
      @alive = @lifes != 0
    end
  end
end