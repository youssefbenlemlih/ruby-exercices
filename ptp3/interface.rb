require_relative 'converter'

class Interface
  def initialize
    @converter = Converter.new
    @allowed_units = @converter.list_units
  end

  def next_input
    print ">> "
    gets.strip.chomp
  end

  def interact
    puts "Welchen Wert wollen Sie umrechnen? [Bsp:100km]"
    first_input = next_input
    while !valid_first_input?(first_input)
      puts "ungultige eingabe. Bitte erneut versuchen [Bsp:50mm]"
      first_input = next_input
    end
    puts "Was ist die Zieleinheit du der Sie umrechnen wollen?? [Bsp:mm]"
    second_input = next_input
    while !valid_second_input?(second_input)
      puts "ungultige eingabe. Bitte erneut versuchen [Bsp:cm]"
      second_input = next_input
    end
    num = (first_input.match(/\d*/)[0]).to_i
    unit_from = first_input.delete_prefix(num.to_s)
    unit_to = second_input
    puts "#{first_input} = #{@converter.convert(num,unit_from,unit_to)} #{unit_to}"
  end
  def valid_first_input?(input)
    matches = /^\d+([a-z].*)/m.match(input)
    unit = matches.nil? ? false : matches[1]
    @allowed_units.include?(unit)
  end
  def valid_second_input?(input)
  @allowed_units.include?(input)
  end
end