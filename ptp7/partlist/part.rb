# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'yaml'
require_relative 'file_handler'
require_relative '../consistency'

class Part
  include Enumerable
  include Consistency

  attr_reader :name, :parent, :parts, :mass
  protected :parts, :mass, :name, :parent

  def initialize(name, mass, parent = nil)
    @name = name.capitalize
    @parts = {}
    @mass = mass
    @parent = parent
  end

  def self.from_file(name)
    a = new(name, 0)
    a.load_partlist
    a
  end

  def [](partname)
    @parts[partname]
  end

  def add_part(name, mass)
    @parts[name] = Part.new(name, mass, self)
  end

  def parts_count
    count = 1
    if @parts.empty?
    else
      @parts.values.each do |p|
        count += p.parts_count
      end
    end
    count
  end

  def attach_to(parent)
    detach
    @parent = parent
    parent[name] = self
  end

  def whole
    @parent || self
  end

  def detach
    if @parent
      @parent.parts.delete(@name)
      @parent = nil
    end
  end

   def calc_mass
    inject(0) { |mass, p| mass + p.mass }
  end

  def to_s
    "#{@name} (#{calc_mass}g)"
  end

  def show_children
    puts "Direkt zugehörige Teile von #{@name}:"
    @parts.each_value do |val|
      puts "\s|- #{val}"
    end
  end

  def show_parent
    @parent.nil? ? "#{@name} ist bereits das oberste ganze Teil." : "Das Teil gehört zu: #{@parent}"
  end

  def print_tree
    puts get_tree
  end


  def top
    @parent.nil? ? self : @parent.top
  end

  def each
    if block_given?
      yield self
      @parts.each_value do |part|
        part.each do |p|
          yield(p)
        end
      end
    end
  end

  def load_partlist
    partlist = FileHandler.load_yaml(@name)
    tree = find_first(@name, partlist)

    unless tree.nil?
      fetch_parts(tree)
      @parts = @parts[@name].parts
    end
  end

  protected

  def depth
    if @parts.empty?
      0
    else
      depths = []
      @parts.each_value do |value|
        depths << value.depth
      end
      depths.max + 1
    end
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

  def get_tree(indent = 0)
    str = "#{'   ' * indent}|__#{to_s}\n|"
    unless @parts.empty?
      indent += 1
      sorted = @parts.values.sort_by { |v| v.depth }
      sorted.each do |value|
        str += value.get_tree(indent)
      end
    end
    str
  end

end
