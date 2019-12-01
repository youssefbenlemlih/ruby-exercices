# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# Definition of a symbol with interpolation
var = "a#{1 + 1}".to_sym
var2 = :"a#{2 + 2}"

puts var.inspect
puts var2.inspect
