# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require 'yaml'
require_relative 'file_handler'
require_relative '../consistency'

class Part
  include Enumerable
  include Consistency
  include FileHandler

  attr_reader :mass, :name, :parent
  protected :mass, :name, :parent

  @@parts = {}

  def initialize(name, mass = 0, parent = nil)
    @name = name.capitalize
    @listname = if FileHandler.exists?(name)
                  name
                else
                  FileHandler.search(name)[/\/(\w*)\.yml/, 1]
                end

    unless @@parts[@listname].is_a?(Array)
      @@parts[@listname] = []
      partlist = load_partlist
      p = Part.new(@listname)
      @@parts[@listname] << p
      p.fetch_parts(partlist)
    end

    if mass.zero? && parent.nil?
      # we only get in here at the initial Part call
      # TODO: calc mass here
      @parent = @@parts[@listname].select { |part| part.name == @name }[0]
    else
      @parent = parent
      @mass = mass
      # @parent[name] = self unless @parent.nil?
    end
  end

  def load_partlist
    YAML.load_file(FileHandler.partlist_path(@listname))
  end

  # @return [Hash] of Part objects
  def fetch_parts(hash)
    hash.each do |k, v|
      if v.is_a?(Array)
        # val is another list of parts which belongs to key
        p = Part.new(k, 0, self)
        @@parts[@listname] << p
        v.each do |innerhash|
          p.fetch_parts(innerhash)
        end
      else
        # val is at the end of part tree, so we've got a mass
        @@parts[@listname] << Part.new(k, v, self)
      end
    end
  end

  def [](partname)
    @parts[partname]
  end

  def add_part(name, mass)
    @parts << Part.new(name, mass, self)
  end

  def to_s
    "#{@name} (#{@mass}g)"
  end

  def show_children
    parent = self
    children = ''
    @@parts[@listname].each do |val|
      if val.name == @name
        parent = val
        next
      end
      children << "\n\s|- #{val}" if val.parent == parent
    end
    children != '' ? "Direkt zugehörige Teile:\n#{@name}#{children}" : "#{@name} ist ein unterstes Teil"
  end

  def show_tree
    indent = 0
    parent = nil
    tree = ''
    @@parts[@listname].each do |val|
      if parent != val.parent
        parent = val
        indent += 1
      end
      tree << "\n#{"\s" * indent}|- #{val}"
    end
    'Stücklistenstruktur:' + tree
  end

  def top
    "Oberstes Teil: " + @@parts[@listname][0].to_s
  end

=begin
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
=end

  protected

  def each
    @parts.each { |part| yield(part) }
  end

  private

=begin
  def calc_mass
    inject(0) { |sum, part| sum + part.mass }
  end
=end

end
