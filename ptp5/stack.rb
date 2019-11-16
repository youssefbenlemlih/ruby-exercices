# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# Error class for push errors
class StackPushError < StandardError; end

# Error class for pop errors
class StackPopError < StandardError; end

# A simple Stack where it is only possible to add elements to the top
# and we only get the last added element at once
class Stack
  attr_reader :content
  protected :content

  def initialize
    @content = []
  end

  def push(elem)
    raise(StackPushError, 'You cannot add nil to this Stack!') if elem.nil?

    @content.insert(@content.length, elem)
    elem
  end

  def <<(elem)
    push(elem)
  end

  def pop
    raise(StackPopError, 'The Stack is empty, you cannot pop anything of it!') if empty?

    @content.delete_at(0)
  end

  def empty?
    @content.empty?
  end

  def ==(other)
    return false if self.class != other.class

    @content == other.content
  end

  def hash
    @content.hash
  end

  def to_s
    @content.to_s
  end

  alias eql? ==
end
