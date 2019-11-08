require_relative 'Queue'
require_relative 'Stack'

q1 = Queue.new
q2 = Queue.new
s1 = Stack.new
s2 = Stack.new

# puts q1.dequeue

q1.enqueue('jo')
q1.enqueue(6)

puts q1 == q2

q2.enqueue('jo')
q2.enqueue(6)

puts q1 == q2
