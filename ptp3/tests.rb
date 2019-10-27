# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
# Class for testing the application
require 'test/unit'
require_relative 'interface'
require_relative 'converter'

class Tests < Test::Unit::TestCase
  def setup
    @interface = Interface.new
    @converter = Converter.new

    @first_input_params = [
      [true, '100m'],
      [true, '100km'],
      [true, '10.03kg'],
      [true, '100 m'],
      [false, 'g100m'],
      [true, '.3m'],
      [false, 'm'],
    ]
    @second_input_params = [
      [true, 'kg', 't'],
      [true, 'mm', 'ft'],
      [false, 'mm', 'kg'],
      [false, 'mm', '1'],
      [false, 'kg', 'g t'],
    ]

    File.open('./test_data/converter_test_data.json') do |file|
      @converter_data = JSON.parse(file.read.chomp)
    end
  end

  def test_interface
    @first_input_params.each do |e|
      assert_equal(e[0], @interface.valid_first_input?(e[1]), "line:#{e[0]},#{e[1]}")
    end
    @second_input_params.each do |e|
      @interface.converter.category!(e[1])
      assert_equal(e[0], @interface.valid_second_input?(e[2]), "line:#{e[1]},#{e[2]},#{e[0]}")
    end
  end

  def test_converter
    @converter_data.each_value do |e|
      value1 = e[0]
      unit1 = e[1]
      value2 = e[2]
      unit2 = e[3]
      @converter.category!(unit1)
      # from value1 to value2
      assert_equal(value2, @converter.convert(value1, unit1, unit2),
                   "line: v1=#{value1} u1=#{unit1} v2=#{value2} u2=#{unit2}")
      # from value2 to value1
      assert_equal(value1, @converter.convert(value2, unit2, unit1),
                   "line: v1=#{value2} u1=#{unit2} v2=#{value1} u2=#{unit1}")
    end
  end
end
