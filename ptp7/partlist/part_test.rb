require_relative 'part'
require 'test/unit'

class TestPart < Test::Unit::TestCase
  def setup
    @fahrrad = Part.from_file('Fahrrad')
    @lenker = Part.from_file('lenker')
  end

  def test_part
    assert_equal(7610, @fahrrad.mass)
    assert_equal(310, @lenker.mass)
    assert_equal(10, @fahrrad.parts_count)
    assert_equal(10, @fahrrad.count)
    @lenker.add_part('Spiegel', 20)
    assert_equal(@lenker, @lenker['Klingel'].top)
    assert_equal(@lenker, @lenker['Spiegel'].whole)
  end
end