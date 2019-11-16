# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# Error class for enqueue errors
class QueueEnqueueError < StandardError; end

# Error class for dequeue errors
class QueueDequeueError < StandardError; end

# A simple Queue where elements are added to the top and
# we only get the element that lastet the longest time within the Queue
class Queue
  attr_reader :content
  protected :content

  def initialize
    @content = []
  end

  def enqueue(elem)
    raise(QueueEnqueueError, 'You cannot add nil to this Queue!') if elem.nil?

    @content << elem
    elem
  end

  def <<(elem)
    enqueue(elem)
  end

  def dequeue
    raise(QueueDequeueError, 'The Queue is empty, you cannot dequeue anything of it!') if empty?

    @content.shift
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
