# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'yaml'
require_relative 'file_handler'
require_relative '../consistency'

class Part
  include Enumerable
  include Consistency
  include FileHandler

  attr_reader :name, :parent, :parts
  attr_accessor :mass
  protected :mass, :name, :parent, :parts

  def initialize(name, mass = 0, parent = nil)
    @name = name.capitalize
    @listname = if FileHandler.exists?(name)
                  name
                else
                  FileHandler.search(name)[/\/(\w*)\.yml/, 1]
                end

    @partlist = load_partlist
    partlist_sub = find_first(@name, @partlist)[@name]
    @parts = if partlist_sub.is_a?(Array)
               fetch_parts(partlist_sub)
             else
               []
             end
    @mass = if partlist_sub.is_a?(Array)
              calc_mass(partlist_sub)
            else
              partlist_sub
            end
  end

  def load_partlist
    YAML.load_file(FileHandler.partlist_path(@listname))
  end

  def fetch_parts(partlist_sub)
    parts = []
    partlist_sub.each do |hash|
      hash.each do |key, val|
        if val.is_a?(Numeric)
          parts << Part.new(key, val, self)
        elsif val.is_a?(Array)
          parts << Part.new(key, calc_mass(find_first(key, @partlist)[key]), self)
        end
      end
    end
    parts
  end

  # @param [Array] parts
  def calc_mass(parts)
    mass = 0
    parts.each do |hash|
      hash.each_value do |val|
        if val.is_a?(Numeric)
          mass += val
        elsif val.is_a?(Array)
          mass = calc_mass(val)
        end
      end
    end
    mass
  end

  def add(name, mass)
    @parts << Part.new(name, mass, self)
  end

  def to_s
    "#{@name} (#{@mass}g)"
  end

  def show_children
    children = ''
    @parts.each do |part|
      children << "\n\s|- #{part}"
    end
    children != '' ? "Direkt zugehörige Teile:\n#{@name}#{children}" : "#{@name} ist ein unterstes Teil"
  end

  def show_tree(indent = 0)
    tree = ''
    @parts.each do |part|
      if !part.parts.empty?
        tree << part.show_tree(indent + 1)
      else
        tree << "\n#{"\s" * indent}|- #{part}"
      end
    end
    tree
  end

  def top
    "Oberstes Teil: " + @listname
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

  def each
    @parts.each { |part| yield(part) }
  end

end
