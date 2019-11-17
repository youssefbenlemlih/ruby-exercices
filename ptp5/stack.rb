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

  # Adds an element to the Stack
  # Throws a StackPushError if the element is nil
  # @param elem: The element to add
  def push(elem)
    raise(StackPushError, 'You cannot add nil to this Stack!') if elem.nil?

    @content.insert(@content.length, elem)
    elem
  end

  # Adds an element to the Stack
  # Throws a StackPushError id the element is nil
  # @param elem: The element to add
  def <<(elem)
    push(elem)
  end

  # Pops out the last element in the Stack
  # Throws a StackPopError if the Stack is not empty
  def pop
    raise(StackPopError, 'The Stack is empty, you cannot pop anything of it!') if empty?

    @content.delete_at(0)
  end

  # Whether the Stack is empty (contains no element)
  def empty?
    @content.empty?
  end

  # Whether the Stacks are equal (contain the same elements)
  def ==(other)
    return false if self.class != other.class

    @content == other.content
  end

  # Needed method to use a Stack as a Key in a Hash
  def hash
    @content.hash
  end

  # String representation of the Stack
  def to_s
    @content.to_s
  end

  # Whether the Stacks are equal (contain the same elements)
  alias eql? ==
end
