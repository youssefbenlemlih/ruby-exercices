# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'yaml'
require_relative 'file_handler'
require_relative '../consistency'

class Part
  include Enumerable
  include Consistency
  include FileHandler

  attr_reader :mass, :name
  protected :mass, :name

  def initialize(name, mass = 0, parent = nil)
    @name = name.capitalize
    @parts = {}
    if mass.zero? && parent.nil?
      load_partlist
    else
      @mass = mass
      @parent = parent
      # @parent[name] = self unless @parent.nil?
    end
  end

  def load_partlist
    path = FileHandler.search(@name)
    raise(StandardError, "No partlist belonging to #{@name}!") if path.empty?

    partlist = YAML.load_file(path)
    tree = find_first(@name, partlist)

    fetch_parts(find_first(@name, tree)) unless tree.nil?
  end

  def find_first(name, partlist)
    partlist.each do |key, value|
      if key == name
        return {key => value}
      elsif value.is_a?(Array)
        value.each do |hash|
          result = find_first(name, hash)
          return result unless result.nil?
        end
      end
    end
    nil
  end

  def fetch_parts(hash)
    hash.each do |k, v|
      if v.is_a?(Array)
        p = Part.new(k, 0, self)
        v.each { |innerhash| p.fetch_parts(innerhash) }
        @parts[k] = p
      else
        @parts[k] = Part.new(k, v, self)
      end
    end
  end

  def [](partname)
    @parts[partname]
  end

  def add_part(name, mass)
    @parts << Part.new(name, mass, self)
  end


=begin
  def load_from_file(name)
    if FileHandler.exists?(name)
      FileHandler.subparts(name).each do |part|
        @parts << Part.new(part[:name], part[:mass])
      end
    elsif !(path = FileHandler.search(name)).empty?
      mass = FileHandler.mass(path, name)
    end
    @mass = mass.zero? ? calc_mass : mass
    path = FileHandler.search(@name)
    n false if path.empty?

    Part.new(FileHandler.filename(path))
  end
=end

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

  def show_children
    puts @parts
    puts "Direkt zugehörige Teile von #{@name}:"
    @parts.each_value do |val|
      puts "\s|- #{val}"
    end
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
    @parent
  end

  private

  def calc_mass
    inject(0) { |sum, part| sum + part.mass }
  end

end
