require_relative "queue"
require_relative "stack"

q1 = Queue.new
q2 = Queue.new
s1 = Stack.new
s2 = Stack.new

begin
  puts "q1.empty? #=> #{q1.empty?} (expected: true)"

  q1.enqueue("jo")
  q1.enqueue(false)

  puts "q1 == q2 #=> #{q1 == q2} (expected: false)"

  q2.enqueue("jo")
  q2.enqueue(false)

  puts "q1 == q2 #=> #{q1 == q2} (expected: true)"

  q2.enqueue(/dasd/)
  puts "q1 == q2 #=> #{q1 == q2} (expected: false)"

  # q2.enqueue(nil)
  # puts 'nil enqueued!'

  puts "q1: #{q1.to_s}"
  puts "q2: #{q2.to_s}"
rescue QueueError => qe
  puts "\nQueueError: #{qe.message}"
  qe.backtrace.each do |loc|
    puts "in: #{loc}"
  end
rescue ArgumentError => ae
  puts "\nArgumentError: #{ae.message}"
  ae.backtrace.each do |loc|
    puts "in: #{loc}"
  end
rescue => e
  puts "\nError: #{e.message}"
  e.backtrace.each do |loc|
    puts "in: #{loc}"
  end
end
