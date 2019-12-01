# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'part'

# @fahrrad = Part.new('fahrrad')
# @klingel = Part.new('Klingel')
@part = Part.new('lenker')

puts @part.show_children
puts
puts @part.top
puts
puts @part.show_tree

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