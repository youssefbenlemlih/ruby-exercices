require 'json'

class Converter
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @factors = JSON.parse(units_config)
    end
  end

  def convert(num, u1, u2)
    b1 = base_unit(u1)
    b2 = base_unit(u2)
    if b1 && b2 && b1 == b2
      return num * @factors[b1][u1] / @factors[b2][u2]
    end
    nil
  end

  def list_units
    units = []
    @factors.each_value do |val|
      val.each_key { |key| units << key }
    end
    units
  end

  def base_unit(unit)
    @factors.each { |key, val| return key if val.keys.include?(unit) }
    nil
  end

end