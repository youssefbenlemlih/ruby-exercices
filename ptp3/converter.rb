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
    # num * (units[u1]['factor'].to_r + units[u1]['delta']) /
    #   (units[u2]['factor'].to_r + units[u2]['delta'])

    # Funktioniert für alle Einheiten und Temperaturumrechnungen mit Fahrenheit, aber nicht für zB Kelvin zu Celsius
    base = (num + units[u1]['delta']) * units[u1]['factor'].to_r
    base * (1 / units[u2]['factor'].to_r) - units[u2]['delta']
  end

=begin
  def convert(num, u1, u2)
    units = @units_config[unit_category(u1)]['units']
    base = if u1 == 'fahrenheit'
             (num + units[u1]['delta']) * units[u1]['factor'].to_r
           else
             num * units[u1]['factor'].to_r - units[u1]['delta']
           end
    divisor = if u2 == 'fahrenheit'
                (num * units[u2]['factor'].to_r) - units[u2]['delta']
              else
                units[u2]['factor'].to_r + units[u2]['delta']
              end
    base / divisor
  end
=end

  def convert_with_formular(cat, num, u1, u2)
    kelvin = cat[u1]['to-kelvin']
    puts kelvin
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