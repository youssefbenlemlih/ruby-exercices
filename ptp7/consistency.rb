# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# Module for ==, eql? and hash methods in order to get objects
# working in Arrays, Sets and Hashes
module Consistency
  # == method inspired by Birgit Wendholdt
  # @param [Object] other
  # @return [Boolean]
  def ==(other)
    return true if equal?(other)
    return false unless other.is_a?(self.class)

    self_ivs = instance_variables.sort
    other_ivs = other.instance_variables.sort
    return false if self_ivs != other_ivs

    self_ivs.each do |iv|
      return false if instance_variable_get(iv) != other.instance_variable_get(iv)
    end
    true
  end

  alias eql? ==

  # @return [Integer] unique hashcode for an object based on all instance variables
  def hash
    #TODO hash der Werte
    instance_variables.hash
  end
end