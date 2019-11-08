require 'test/unit'
require_relative 'Queue'

class TestQueue < Test::Unit::TestCase
  def setup
    @q1 = Queue.new
    @q2 = Queue.new
  end

  def test_enqueue
    assert(@q1.enqueue(5))
    # assert_raise..? @q1.enqueue(nil)
  end

  def test_dequeue
    # assert_raise...? @q1.dequeue
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