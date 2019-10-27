# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
# This class manages frontend interaction with the user,
# validates inputs, outputs results
require_relative 'converter'

class Interface
  # Set up some essential attributes
  def initialize
    @converter = Converter.new
    @all_units = @converter.list_units
  end

  # get and preprocess input string
  # design (print '>>') inpsired by Birgit Wendholdt
  # @return [String]
  def next_input
    print '>> '
    gets.chomp.strip.downcase
  end

  # Manages and visualizes program flow for the user
  def interact
    begin
      puts 'Welchen Wert wollen Sie umrechnen? [Bsp:100km]'
      puts "Erlaubte Einheiten: #{@all_units}"
      first_input = next_input
      until valid_first_input?(first_input)
        puts 'Ungueltige Eingabe. Bitte erneut versuchen [Bsp:50 mm]'
        puts "Erlaubte Einheiten: #{@all_units}"
        first_input = next_input
      end
      num = (first_input[/[-\d.]+/]).to_f
      unit_from = (first_input[/[a-z]+.*/])
      @converter.category!(unit_from)

      puts 'Was ist die Zieleinheit, zu der Sie umrechnen wollen?'
      puts "Erlaubte Einheiten: #{allowed_units}"
      second_input = next_input
      until valid_second_input?(second_input)
        puts 'Ungueltige Eingabe. Bitte erneut versuchen'
        puts "Erlaubte Einheiten: #{allowed_units}"
        second_input = next_input
      end
      unit_to = second_input
      result = @converter.convert(num, unit_from, unit_to)
      if result
        puts "#{num} #{unit_from} = #{result} #{unit_to}"
      else
        puts "Kann nicht von #{unit_from} zu #{unit_to} konvertieren"
      end
      puts 'Wollen Sie eine andere Konversion machen? [j/ja/nein/n]'
    end while %w[ja j].include?(next_input)
  end

  # Check if given input is a unit as part of units_config.json
  # @return [bool]
  def valid_first_input?(input)
    unit = input[/^[-\d .]+(.*)/m, 1]
    @all_units.include?(unit)
  end

  # Check if given input is in the same input category
  # @return [bool]
  def valid_second_input?(second_input)
    allowed_units.include?(second_input)
  end

  # delivers an array of all units within the category
  # which has been set after validating first input
  # @return [Array]
  def allowed_units
    @converter.list_units(true)
  end
end
