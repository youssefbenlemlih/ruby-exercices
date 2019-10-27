# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'json'

class Converter
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @units_config = JSON.parse(units_config)
    end
  end

  def convert(num, u1, u2)
    units = @units_config[unit_category(u1)]
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
    result.to_f
  end

  # @param [String] category
  # @return [Array]
  def list_units(category = '')
    units = []
    if category == ''
      @units_config.each_value do |val|
        val.each_key { |key| units << key }
      end
    else
      @units_config[category].each_key { |key| units << key }
    end
    units
  end

  def unit_category(unit)
    @units_config.each do |key, val|
      return key if val.keys.include?(unit)
    end
    nil
  end

end