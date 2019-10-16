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
puts "\n[3.1] Collatz-Folge"
puts collatz ? "Startwert: #{collatz['start']}, Index: #{collatz['index']}" : "Falscher Startwert"

puts "\n[3.2] Berechnung von Pi"
precision = 0
1.times do
  puts "PI mit der Genauigkeit von #{precision} Nachkommastellen : #{methods.approx_pi(precision)}"
  precision += 1
end

puts "\n[3.3] Konvergenz gegen 1"
precision = 10 ** -1
8.times do
  result = methods.approx_1(precision)
  puts "Konvergenz gegen 1 mit einer Genauigkeit von #{precision}: \n\tWerte: #{result['values'].to_s}\n\tIndex: #{result['index']}\n\tSum: #{result['sum']}"
  precision *= 10**- 1
end

puts "\n[3.4] Aethiopische Multiplikation"
5.times do
  a = rand(0...12)
  b = rand(0...12)
  result =  methods.egyptian_multiplication(a,b)
  puts "#{a} * #{b} = #{result}"
end

