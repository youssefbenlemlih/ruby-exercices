# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'test/unit'
require_relative 'interface'

class Tests < Test::Unit::TestCase
  def setup
    @interface = Interface.new
    @first_input_params = [
        [true, '100m'],
        [true, '100km'],
        [true, '10.03kg'],
        [true, '100 m'],
        [false, 'g100m'],
        [true, '.3m'],
        [false, 'm']
    ]
    @second_input_params = [
        [true, 'kg', 't'],
        [true, 'mm', 'ft'],
        [false, 'mm', 'kg'],
        [false, 'mm', '1'],
        [false, 'kg', 'g t']
    ]

    @converter = Converter.new
    @converter_data=[
      #lenght tests
      [10,'km','m',10000],
      [10,'m','m',10],
      [5,'mm','cm',0.5],
      [5,'mm','m',0.005],
      [10,'km','m',10000],
      # mass tests

      # temperature tests
      [0,'celsius','fahrenheit',32],
      [-0,'celsius','fahrenheit',32],
      [100,'celsius','fahrenheit',212],
      [-49,'fahrenheit','celsius',-45],
      [0.0,'celsius','kelvin',273.15],
      [25,'celsius','kelvin',298.15],
      [25,'celsius','kelvin',298.15],
      [0.79,'kelvin','celsius',-272.36]
      # old units tests
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

  def test_converter
    assert_equal('temperature', @converter.unit_category('celsius'))
    @converter_data.each do|e|
      assert_equal(e[3],@converter.convert(e[0],e[1],e[2]))
    end
  end
end