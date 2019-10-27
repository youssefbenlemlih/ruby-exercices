# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
# This class manages conversions and delivers all information related to units
require 'json'

class Converter
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @units_config = JSON.parse(units_config)
    end
    @unit_category = ''
  end

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

  def round_result(result)
    digits = @units_config[@unit_category]['precision']
    result.round(digits)
  end

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

  def category!(unit)
    @units_config.each do |key, val|
      @unit_category = key if val['units'].keys.include?(unit)
    end
    nil
  end

end