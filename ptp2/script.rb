# Author:: Jonas Krukenberg
# Author:: Youssef Benlemlih
require_relative 'number_methods'
methods = NumberMethods.new

numbers = [1, 9, 10]
puts "[1] Summe der Zahlen aus dem Array #{numbers.to_s}:"
puts methods.sum(numbers)

puts "\n[2] Produkt der Zahlen aus dem Array #{numbers.to_s}:"
puts methods.product(numbers)

collatz = methods.collatz(10)
puts "\n[3] Collatz-Folge"
puts collatz ? "Startwert: #{collatz['start']}, Index: #{collatz['index']}" : "Falscher Startwert"

puts "\n[4] Berechnung von Pi"
precision = 0
5.times do
  puts "PI mit der Genauigkeit von #{precision} Nachkommastellen : #{methods.approx_pi(precision)}"
  precision += 1
end
