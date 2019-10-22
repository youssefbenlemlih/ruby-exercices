require 'test/unit'
require_relative 'interface'

class Tests < Test::Unit::TestCase
  def setup
    @interface = Interface.new
    @first_input_params = [
        [true, '100m'],
        [true, '100km'],
        [true, '10.03kg'],
        [false, 'g100m'],
        [true, '100 m'],
        [false, '.3m']
    ]
    @second_input_params = [
        [true, 'kg', 't'],
        [true, 'mm', 'ft'],
        [false, 'mm', 'kg'],
        [false, 'mm', '1']
    ]
  end

  def test_interface
    @first_input_params.each do |e|
      assert_equal(e[0], @interface.valid_first_input?(e[1]), "line:#{e[0]},#{e[1]}")
    end
    @second_input_params.each do |e|
      assert_equal(e[0], @interface.valid_second_input?(e[1], e[2]), "line:#{e[1]},#{e[2]},#{e[0]}")
    end
  end
end