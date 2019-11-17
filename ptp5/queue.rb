# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# Error class for enqueue errors
class QueueEnqueueError < StandardError; end

# Error class for dequeue errors
class QueueDequeueError < StandardError; end

# A simple Queue where elements are added to the top and
# only the last one can be retrieved (First in last out)
class Queue
  attr_reader :content
  protected :content

  def initialize
    @content = []
  end

  # Adds an element to the queue
  # Throws a QueueEnqueueError id the element is nil
  # @param elem: The element to add
  def enqueue(elem)
    raise(QueueEnqueueError, 'You cannot add nil to this Queue!') if elem.nil?

    @content << elem
    elem
  end

 # Adds an element to the queue
 # Throws a QueueEnqueueError id the element is nil
 # @param elem: The element to add
  def <<(elem)
    enqueue(elem)
  end


  # Pops out the last element in the queue
  # Throws a QueueEnqueueError id the queue is not empty
  # @param elem: The element to add
  def dequeue
    raise(QueueDequeueError, 'The Queue is empty, you cannot dequeue anything of it!') if empty?

    @content.shift
  end

  # Wether the Queue is empty (contains no element)
  def empty?
    @content.empty?
  end

  # Wether both Queues contain the same elements
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
