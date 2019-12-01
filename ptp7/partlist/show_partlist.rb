# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'part'

# @fahrrad = Part.new('fahrrad')
# @klingel = Part.new('Klingel')
@part = Part.new('fahrrad')

puts @part.show_children
puts
puts @part.top
puts
puts "Baum für #{@part}:" + @part.show_tree

# @part.each { |p| puts p.inspect}

# puts @fahrrad.to_s
# puts @fahrrad["fahrrad"].to_s
# puts @fahrrad["fahrrad"]["Lenker"].to_s
# puts @fahrrad["fahrrad"]["Lenker"].to_s
# puts @fahrrad["fahrrad"].to_s
# @klingel = Part.new('klingel')
#
# puts @fahrrad.show_children
# puts
# puts Part.new('lenker').show_children
# puts
# puts @klingel.show_children
# puts
# puts "Teil, zu dem #{@klingel} gehört: " + @klingel.show_parent
# puts
# puts "Oberstes Teil: von #{@klingel}: " + @klingel.top=end