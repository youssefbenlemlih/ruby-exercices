require_relative "stack_error"

class Stack
  def initialize
    @content = []
  end

  def enqueue(elem)
    raise(StackError, "You cannot add nil to this Queue!") if elem.nil?

    @content.insert(@content.length, elem)
    elem
  end

  def dequeue
    raise(StackError, "The Stack is empty, you cannot dequeue anything of it!") if empty?
    @content.delete_at(0)
  end

  def empty?
    @content.empty?
  end

  def ==(other)
    return false if self.class != other.class

    @content == other.content
  end

  def eql?(other)
    self.== other
  end

  def to_s
    @content.to_s
  end
end
