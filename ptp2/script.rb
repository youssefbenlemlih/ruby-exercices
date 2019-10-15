# Author:: Jonas Krukenberg
require_relative 'number_methods'
methods = NumberMethods.new

numbers = [1, 9, 10]
puts "[1] Summe der Zahlen aus dem Array #{numbers.to_s}:"
puts methods.sum(numbers)

puts "\n[2] Produkt der Zahlen aus dem Array #{numbers.to_s}:"
puts methods.product(numbers)

collatz = methods.collatz(10)
puts "\n[3] Collatz-Folge"
puts "Startwert: #{collatz['start']}, Index: #{collatz['index']}"

puts "\n[4] Berechnung von Pi"
methods.approx_pi(2)