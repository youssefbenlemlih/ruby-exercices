# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'part'

@fahrrad = Part.from_file('Fahrrad')
@fahrrad2 = Part.from_file('Lenker')
@fahrrad.show_children
@fahrrad.print_tree
p @fahrrad.hash
p @fahrrad2.hash
enumerator = @fahrrad.each do |p|
  puts p
  end
puts enumerator.inspect
# puts @fahrrad.inject(0) { |mass, p| mass + p.mass }
# @fahrrad.each do |p|
#   puts p.mass
# end
#@klingel = Part.from_file('klingel')
#@lenker = Part.new('Lenker', 20)
#puts "mass=#{@lenker.mass}"
#@lenker.print_tree
#@lenker.show_children
#Part.from_file("Lenker").print_tree
#Part.from_file("Klingelhebel").print_tree
#a = Part.new("a", 50)
#a.add_part('b', 10)
#a.add_part('c', 10)
#c = a["c"]
#
#puts a
#puts a.parts_count
#puts c.top
#c.detach
#
#puts a
#puts c.top
## @lenker.show_chil/l.top=end