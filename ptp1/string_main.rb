# A dummy script to show off the static methods of the class StringUtil
# Author::Youssef Benlemlih
# Author::Jonas Krukenberg
require_relative('./classes/string_util')

puts('Please enter the initial string:')
# Get the user input and chomp the \r\n
input = gets.chomp

puts("\n")
puts("| The input string:        | '#{input}'")
puts("| The reversed string:     | '#{StringUtil.reverse(input)}'")
puts("| All chars uppercase:     | '#{StringUtil.upcase(input)}'")
puts("| All chars downcase:      | '#{StringUtil.downcase(input)}'")
puts("| Swap case:               | '#{StringUtil.swapcase(input)}''")
puts("| Replace vocals by '*':   | '#{StringUtil.censor_small_vowels(input)}'")
puts("| Double consonants with o:| '#{StringUtil.kokify(input)}'")
puts("\n")