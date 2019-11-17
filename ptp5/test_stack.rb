# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require "test/unit"
require_relative "stack"

class TestStack < Test::Unit::TestCase
  def setup
    @s1 = Stack.new
    @s2 = Stack.new
  end

  def test_push
    assert_nothing_raised { @s1.push(9) }
    assert_raise(StackPushError) { @s1.push(nil) }
    assert(@s1 << 10)
  end

  def test_pop
    assert_raise(StackPopError) { @s1.pop }
    @s1.push(5)
    assert_nothing_raised { @s1.pop }
  end

  def test_empty
    assert(@s2.empty?)
    @s2.push(5)
    assert_false(@s2.empty?)
  end

  def test_comparison
    stacks = {}
    stacks[@s1] = 'test'

    @s1.push(3)
    assert(@s1 != @s2)
    assert_nil(stacks[@s2])
    @s2.push(3)
    assert(@s1 == @s2)

    assert_equal('test', stacks[@s2])
    assert_false(@s1 == [10, 11])
    assert_false(@s1.eql?([10, 11]))
  end
end
