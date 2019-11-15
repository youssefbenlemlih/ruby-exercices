# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'test/unit'
require_relative 'queue'

class TestQueue < Test::Unit::TestCase
  def setup
    @q1 = Queue.new
    @q2 = Queue.new
  end

  def test_enqueue
    assert_nothing_raised { @q1.enqueue(5) }
    assert_raise(QueueEnqueueError) { @q1.enqueue(nil) }
  end

  def test_dequeue
    assert_raise(QueueDequeueError) { @q2.dequeue }
    @q2.enqueue(5)
    assert_nothing_raised { @q2.dequeue }
  end

  def test_empty
    assert(@q1.empty?)
    @q1.enqueue(false)
    assert_false(@q1.empty?)
  end

  def test_comparison
    assert(@q1 == @q2)
    @q1.enqueue(0)
    assert_false(@q1 == @q2)
  end
end
