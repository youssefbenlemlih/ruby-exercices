# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'queue_error'

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

  def eql?(other)
    self.== other
  end

  def to_s
    @content.to_s
  end
end
