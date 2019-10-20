# Author:: Jonas Krukenberg
# Author:: Youssef Benlemlih
require_relative 'algebra'
algebra = Algebra.new

numbers = [1, 9, 10]
puts "[1] Summe der Zahlen aus dem Array #{numbers.to_s}:"
puts algebra.sum(numbers)

puts "\n[2] Produkt der Zahlen aus dem Array #{numbers.to_s}:"
puts algebra.product(numbers)

collatz = algebra.collatz(10)
puts "\n[3.1] Collatz-Folge"
puts collatz ? "Startwert: #{collatz['start']}, Index: #{collatz['index']}" : 'Falscher Startwert'

puts "\n[3.2] Berechnung von Pi"
6.times do |i|
  precision = 10**-(i + 1)
  pi = algebra.approx_pi(precision)
  puts "PI mit der Genauigkeit von #{precision}: #{pi}"
  puts "\tAls Bruch: #{Rational(pi.to_s)}"
end

puts "\n[3.3] Konvergenz gegen 1"
precision = 10**-1
8.times do
  result = algebra.approx_1(precision)
  puts "Konvergenz gegen 1 mit einer Genauigkeit von #{precision}:"
  if result
    puts "\tWerte (Float): #{result['values_f'].to_s}"
    puts "\tWerte (Bruch): #{result['values_r'].to_s}"
    puts "\tSumme (Float): #{result['sum_f']}"
    puts "\tSumme (Bruch): #{result['sum_r']}"
    puts "\tIndex: #{result['index']}"
  else
    puts 'Ungueltige Genauigkeit!'
  end
  precision *= 10**-1
end

puts "\n[4] Aethiopische Multiplikation"
5.times do
  a = rand(0...12)
  b = rand(0...12)
  result = algebra.ethiopian_multiplication(a, b)
  puts "#{a} * #{b} = #{result}"
end

