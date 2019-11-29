# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'file_handler'
require_relative '../consistency'

class Part
  include Enumerable
  include Consistency
  include FileHandler

  attr_reader :mass, :name
  protected :mass, :name

  def initialize(name, mass = 0)
    @name = name.capitalize
    @parts = []

    if FileHandler.exists?(name)
      FileHandler.subparts(name).each do |part|
        @parts << Part.new(part[:name], part[:mass])
      end
    elsif !(path = FileHandler.search(name)).empty?
      mass = FileHandler.mass(path, name)
    end
    @mass = mass.zero? ? calc_mass : mass
  end

  def to_s
    "#{@name} (#{@mass}kg)"
  end

  def show_children
    return "'#{@name}' hat keine Stückliste." if @parts.empty?

    longest = @parts.inject('') { |memo, part| memo.length > part.name.length ? memo : part.name }
    parts = ''
    @parts.each { |row| parts += "#{row.part(longest.length)}\n" }
    "Stückliste für #{@name} (#{@mass}kg)\n" +
        "Teil#{' ' * (longest.length - 3)}| Masse\n" + parts
  end

  def show_parent
    parentpart = parent
    !parentpart ? "#{@name} ist bereits das oberste ganze Teil." : parentpart.to_s
  end

  def top
    parentpart = parent
    return "#{@name} ist bereits das Top-Teil." unless parentpart
    return parentpart.to_s unless parentpart.parent

    parentpart.parent.to_s
  end

  protected

  def each
    @parts.each { |part| yield(part) }
  end

  def part(longest)
    "#{@name}#{' ' * (longest - @name.length)} | #{@mass}kg"
  end

  def parent
    path = FileHandler.search(@name)
    return false if path.empty?

    Part.new(FileHandler.filename(path))
  end

  private

  def calc_mass
    inject(0) { |sum, part| sum + part.mass }
  end

end
