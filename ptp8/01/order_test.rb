# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'test/unit'
require_relative './natural_order'

class NaturalTest < Test::Unit::TestCase
  def setup
    @order_12 = NaturalOrder.new(2, 2)
  end

  def test_methods
    assert_equal(12, @order_12.value)
    assert_equal(NaturalOrder.new(3, 1), @order_12.parent)
    assert_equal([NaturalOrder.new(1, 3), NaturalOrder.new(1, 4)], @order_12.children)
  end

  def test_range
    assert_equal([
                     NaturalOrder.new(1, 2),
                     NaturalOrder.new(1, 3),
                     NaturalOrder.new(1, 4)
                 ], (NaturalOrder.new(1, 2)..NaturalOrder.new(1, 4)).to_a)
  end

  def test_alternative_methods
    assert_equal(@order_12.parent, @order_12.parent_fast)
    assert_equal(@order_12.children.sort, @order_12.children_fast.sort)
  end

  def test_all_children
    assert_equal([
                     NaturalOrder.new(1, 3),
                     NaturalOrder.new(1, 4),
                     NaturalOrder.new(0, 5),
                     NaturalOrder.new(0, 6),
                     NaturalOrder.new(0, 7),
                     NaturalOrder.new(0, 8),
                 ].sort, @order_12.children_all.sort)
  end
end