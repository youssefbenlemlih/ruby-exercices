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
    repeat_wanted = true
    while repeat_wanted
      puts "Welchen Wert wollen Sie umrechnen? [Bsp:100km]"
      first_input = next_input
      until valid_first_input?(first_input)
        puts "ungultige eingabe. Bitte erneut versuchen [Bsp:50mm]"
        first_input = next_input
      end
      puts "Was ist die Zieleinheit du der Sie umrechnen wollen?? [Bsp:mm]"
      second_input = next_input
      until valid_second_input?(second_input)
        puts "ungultige eingabe. Bitte erneut versuchen [Bsp:cm]"
        second_input = next_input
      end
      num = (first_input.match(/\d*/)[0]).to_i
      unit_from = first_input.delete_prefix(num.to_s)
      unit_to = second_input
      result = @converter.convert(num, unit_from, unit_to)
      if result
        puts "#{num} #{unit_from} = #{result} #{unit_to}"
      else
        puts "Kann nicht von #{unit_from} zu #{unit_to} konvertieren"
      end
      puts "Wollen Sie eine andere Konversion machen? [j/ja/nein/n]"
      input = next_input
      repeat_wanted = input.downcase == "ja" || input.downcase == "j"
    end
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