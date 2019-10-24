require 'json'

class Converter
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @units_config = JSON.parse(units_config)
    end
  end

  def convert(num, u1, u2)
    units = @units_config[unit_category(u1)]['units']
    num * (units[u1]['factor'] - units[u1]['delta']) / (units[u2]['factor'] - units[u2]['delta'])
  end

  def convert_with_formular(cat, num, u1, u2)
    kelvin = cat['units'][u1]['to-kelvin']
    puts kelvin
  end

  def list_units
    units = []
    @units_config.each_value do |val|
      val['units'].each_key { |key| units << key }
    end
    units
  end

  def unit_category(unit)
    @units_config.each do |key, val|
      return key if val['units'].keys.include?(unit)
    end
    nil
  end

end