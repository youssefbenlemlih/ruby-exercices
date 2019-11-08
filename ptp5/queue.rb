class Queue
  attr_reader :content
  protected :content
  def initialize
    @content = []
  end

  def enqueue(elem)
    raise('enqueue: Das ist eine Exception') if elem.nil?

    @content << elem
  end

  def dequeue
    raise('dequeue: Das ist eine Exception') if empty?

    @content.shift
  end

  def empty?
    @content.empty?
  end

  def ==(other)
    return false if self.class != other.class

    @content == other.content
  end
end