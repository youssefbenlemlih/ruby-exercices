require_relative 'part'
require_relative 'file_handler'

class Partlist
  include FileHandler

  def initialize(majorpart)
    @parts = []
    @name = majorpart
    path = FileHandler.part_path(majorpart)
    raise(ArgumentError, 'No such partlist available!') unless path != ''
    FileHandler.subparts(path).each do |part|
      @parts << Part.new(part[:name], part[:mass])
    end
  end

  def print
    puts "Stückliste für '#{@name}':\n" + @parts.join('')
  end

end

Partlist.new('fahrrad').print
# Partlist.new('lenker').print
