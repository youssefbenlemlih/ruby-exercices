require_relative 'file_handler'

class Part
  include Enumerable
  include FileHandler

  attr_reader :mass, :name
  protected :mass, :name

  def initialize(name, mass = 0)
    @name = name
    @mass = mass.to_f
    @parts = []

    if FileHandler.exists?(name)
      FileHandler.subparts(FileHandler.part_path(name)).each do |part|
        @parts << Part.new(part[:name], part[:mass])
      end
    end
    @mass = calc_mass if @mass == 0
  end

  def calc_mass
    mass = 0
    each do |part|
      mass += part.mass
    end
    mass
  end

  def each(&block)
    @parts.each do |part|
      block.call(part)
    end
  end

  def to_s
    "#{@name} | #{@mass}kg"
  end

  def partlist_row(longest)
    "#{@name}#{' ' * (longest - @name.length)} | #{@mass}kg"
  end

  def print_partlist
    longest = @parts.inject('') { |memo, part| memo.length > part.name.length ? memo : part.name }
    parts = ''
    @parts.each { |row| parts += "#{row.partlist_row(longest.length)}\n" }
    "Stückliste für #{@name} (#{@mass}kg)\n" +
      "Teil#{' ' * (longest.length - 3)}| Masse\n" + parts
  end

end

puts Part.new('fahrrad').print_partlist