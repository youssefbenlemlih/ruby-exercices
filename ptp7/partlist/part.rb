require_relative 'file_handler'

class Part
  include FileHandler

  def initialize(name, mass = 0)
    @name = name
    @mass = mass
    @parts = []

    if contains_parts?
      FileHandler.subparts(FileHandler.part_path(name)).each do |part|
        @parts << Part.new(part[:name], part[:mass])
      end
    end
  end

  def contains_parts?
    Dir["parts/#{@name}.txt"].empty? ? false : true
  end

  def to_s
    "#{@name}\n\tMasse: #{@mass}\n\tTeile: #{@parts.join(', ')}\n"
  end

end