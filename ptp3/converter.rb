# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
# This class manages conversions and delivers all information related to units
require 'json'

class Converter
  # set up array units_config from json file
  # initialize unit_category for later use
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @units_config = JSON.parse(units_config)
    end
    @unit_category = ''
  end

  # performs the actual conversion from one unit to another
  # unit conformity has already been checked at input verification (Interface)
  # @param [Float] num
  # @param [String] u1
  # @param [String] u2
  # @return [Float] result
  def convert(num, u1, u2)
    units = @units_config[@unit_category]['units']
    num = Rational(num)
    d1 = units[u1]['delta'].to_r
    f1 = units[u1]['factor'].to_r
    d2 = units[u2]['delta'].to_r
    f2 = units[u2]['factor'].to_r
    result = if units[u1]['special'] == 'f-d-reversed'
               (num * f1) + d1
             else
               (num + d1) * f1
             end
    result = if units[u2]['special'] == 'f-d-reversed'
               (result - d2) * (1 / f2)
             else
               result * (1 / f2) - d2
             end
    round_result(result.to_f)
  end

  # rounds a Float result to n digits specified in units_config
  # @param [Float] result
  # @return [Float]
  def round_result(result)
    digits = @units_config[@unit_category]['precision']
    result.round(digits)
  end

  # lists all units in current unit category if incategory is true
  # otherwise lists all available units
  # @param [Boolean] incategory
  # @return [Array]
  def list_units(incategory = false)
    units = []
    if !incategory
      @units_config.each_value do |val|
        val['units'].each_key { |key| units << key }
      end
    else
      @units_config[@unit_category]['units'].each_key { |key| units << key }
    end
    units
  end

  # sets unit_category attribute for the converter for working dimension
  # @param [String] unit
  def category!(unit)
    @units_config.each do |key, val|
      @unit_category = key if val['units'].keys.include?(unit)
    end
    nil
  end

end