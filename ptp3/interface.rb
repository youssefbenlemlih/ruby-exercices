# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'converter'

class Interface
  def initialize
    @converter = Converter.new
    @all_units = @converter.list_units
  end

  def next_input
    print '>> '
    gets.chomp.strip.downcase
  end

  def interact
    begin
      puts 'Welchen Wert wollen Sie umrechnen? [Bsp:100km]'
      puts "Erlaubte Einheiten: #{@all_units.to_s}"
      first_input = next_input
      until valid_first_input?(first_input)
        puts 'Ungueltige Eingabe. Bitte erneut versuchen [Bsp:50 mm]'
        puts "Erlaubte Einheiten: #{@all_units.to_s}"
        first_input = next_input
      end
      num = (first_input[/[-\d.]+/]).to_f
      unit_from = (first_input[/[a-z]+.*/])

      puts 'Was ist die Zieleinheit, zu der Sie umrechnen wollen?'
      puts "Erlaubte Einheiten: #{allowed_units(unit_from)}"
      second_input = next_input
      until valid_second_input?(unit_from, second_input)
        puts 'Ungueltige Eingabe. Bitte erneut versuchen'
        puts "Erlaubte Einheiten: #{allowed_units(unit_from)}"
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

  # @return [bool]
  def valid_first_input?(input)
    unit = input[/^[-\d .]+(.*)/m, 1]
    @all_units.include?(unit)
  end

  # @return [bool]
  def valid_second_input?(unit_from, second_input)
    allowed_units(unit_from).include?(second_input)
  end

  # @return [Array]
  def allowed_units(unit)
    @converter.list_units(@converter.unit_category(unit))
  end
end