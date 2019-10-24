require 'json'

class Converter
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @units_config = JSON.parse(units_config)
    end
  end

  def convert(num, u1, u2)
    cat = @units_config[unit_category(u1)]
    case cat['operation']
    when 'multiply'
      return num * cat['units'][u1] / cat['units'][u2]
    when 'formular'
      return convert_with_formular(cat, num, u1, u2)
    when 'count'
      puts 'Anzahl...'
    else
      return '1'
    end
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