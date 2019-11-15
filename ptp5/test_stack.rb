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
    assert(@s1.push(9))
    assert_raise(StackPushError) { @s1.push(nil) }
  end

  def test_pop
    assert_raise(StackPopError) { @s1.pop }
    @s1.push(5)
    assert_equal(5, @s1.pop)
  end

  def test_empty
    assert(@s2.empty?)
    @s2.push(5)
    assert_false(@s2.empty?)
  end

  def test_comparison
    @s1.push(3)
    assert(@s1 != @s2)
    @s2.push(3)
    assert(@s1 == @s2)
  end
end
