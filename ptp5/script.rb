# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'queue'
require_relative 'stack'

q1 = Queue.new
q2 = Queue.new
s1 = Stack.new

begin
  puts "q1.empty? #=> #{q1.empty?} (expected: true)"

  q1 << 'jo'
  q1.enqueue(false)

  puts "q1 == q2 #=> #{q1 == q2} (expected: false)"

  q2.enqueue('jo')
  q2 << false

  puts "q1 == q2 #=> #{q1 == q2} (expected: true)"

  q2.enqueue(/dasd/)
  puts "q1 == q2 #=> #{q1 == q2} (expected: false)"

  # q2.enqueue(nil)

  puts "q1: #{q1.to_s}"
  puts "q2: #{q2.to_s}"

  s1.push(2)
  s1 << 2
  s1.push(3)
  puts s1

rescue => e
  puts "\n#{e.class}: #{e.message}"
  e.backtrace.each do |loc|
    puts " loc: #{loc}"
  end
end
