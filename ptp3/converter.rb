require 'json'

class Converter
  def initialize
    File.open('units_config.json') do |file|
      units_config = file.read.chomp
      @factors = JSON.parse(units_config)
    end
  end

  def convert(num, u1, u2)
    b = base_unit(u1)
    num * @factors[b][u1] / @factors[b][u2]
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