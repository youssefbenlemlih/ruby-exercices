# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
module Consistency
  def ==(other)
    return true if self.equal?(other)
    return false unless other.is_a?(self.class)
    self_ivs = self.instance_variables.sort
    other_ivs = other.instance_variables.sort
    return false if self_ivs != other_ivs
    self_ivs.each do |iv|
      return false if self.instance_variable_get(iv) != other.instance_variable_get(iv)
    end
    true
  end

  alias eql? ==

  def hash
    instance_variables.hash
  end
end