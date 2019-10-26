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
    result = (num + units[u1]['delta']) * units[u1]['factor'].to_r
    result *= (1 / units[u2]['factor'].to_r) - units[u2]['delta']
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