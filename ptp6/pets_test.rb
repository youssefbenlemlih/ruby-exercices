# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'test/unit'
require 'date'
require_relative 'person'
require_relative 'cat'
require_relative 'dog'

class PetsTest < Test::Unit::TestCase
  def setup
    @p_hans = Person.new('hans')
    @p_joe = Person.new('joe')

    @d_bello = Dog.new('bello', Date.new(2019,11,19), @p_hans)
    @d_mike = Dog.new('mike', Date.new(2010,11,1), @p_hans)

    @c_tom = Cat.new("Tom", Date.new(2015,02,14), @p_hans, @p_joe)
    @c_tom2 = Cat.new("Tom", Date.new(2015,02,14), @p_hans, @p_joe)
    @c_jerry = Cat.new("Jerry", Date.new(2015,02,14), @p_hans)
  end

  def test_kill
    assert_false(@c_tom.kill(@c_tom))
  end

  def test_consistency
    assert_equal(@c_tom, @c_tom2)
    assert(@c_tom.eql?(@c_tom2))
    assert_not_equal(@c_tom, @c_jerry)
    h = {}
    h[@c_tom] = 'Thomas'
    assert_equal('Thomas', h[@c_tom2])
  end
end