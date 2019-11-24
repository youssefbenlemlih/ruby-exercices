# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'test/unit'
require 'date'
require_relative 'person'
require_relative 'cat'
require_relative 'dog'

# A class to test Pets (Cats and Dogs)
class PetsTest < Test::Unit::TestCase
  def setup
    @p_hans = Person.new('hans')
    @p_joe = Person.new('joe')

    @d_bello = Dog.new('bello', Date.new(2019, 11, 19), @p_hans)
    @d_mike = Dog.new('mike', Date.new(2010, 11, 1), @p_hans)
    @d_max = Dog.new('max', Date.new(2008, 1, 2), @p_hans)

    @c_tom = Cat.new('Tom', Date.new(2015, 02, 14), @p_hans)
    @c_tom2 = Cat.new('Tom', Date.new(2015, 02, 14), @p_hans)
    @c_jerry = Cat.new('Jerry', Date.new(2015, 02, 14), @p_hans)
  end

  def test_kill
    # A Cat cannot kill itself
    assert_raise(CatError) { @c_tom.kill(@c_tom) }
    # A Dog cannot kill a Cat
    assert_raise(CatError) { @d_bello.kill(@c_tom) }
    # A Dog can kill a Dog
    assert_nothing_raised { @d_bello.kill(@d_mike) }
    # A dead Pet cannot die again
    assert_raise(PetError) { @d_bello.kill(@d_mike) }
  end

  def test_consistency
    # Equality
    assert_equal(@c_tom, @c_tom2)
    assert(@c_tom.eql?(@c_tom2))
    assert_false(@c_tom.equal?(@c_tom2))
    assert_not_equal(@c_tom, @c_jerry)
    # Hashing
    h = {}
    h[@c_tom] = 'Thomas'
    assert_equal('Thomas', h[@c_tom2])
  end

  def test_services
    # A Dog can take service from anyone
    assert_nothing_raised { @c_tom.request_service(@p_hans, :stroke) }
    assert_nothing_raised { @p_joe.give_service(@d_mike, :stroke) }

    # A Pet cannot take a service if dead
    @d_bello.kill(@d_max)
    assert_raise(PetError) { @d_max.get_service(@p_hans, :feed) }
    # A cat receives services from its personal
    assert_nothing_raised { @c_tom.get_service(@p_hans, :stroke) }
    # A Cat cannot receive a service outside of its personal
    assert_raise(CatError) { @c_jerry.request_service(@p_joe, :stroke) }
    # A Pet cannot feed / stroke another Person
    assert_raise(PersonError) { @p_joe.give_service(@p_hans, :stroke) }
    # A Pet cannot feed / stroke another Pet
    assert_raise(PetError) { @d_bello.get_service(@d_mike, :stroke) }
  end
end
