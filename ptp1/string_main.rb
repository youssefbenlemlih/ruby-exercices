# A dummy script to show off the static methods of the class StringUtil
# Author::Youssef Benlemlih
require_relative('./classes/string_util')

puts('Please enter the initial string:')
# Get the user input and chop the \n
input = gets.chop!

puts("\n")
puts("| The input string:        | '#{input}'")
puts("| The reversed string:     | '#{StringUtil.reverse(input)}'")
puts("| All chars uppercase:     | '#{StringUtil.upcase(input)}'")
puts("| All chars downcase:      | '#{StringUtil.downcase(input)}'")
puts("| Swap case:               | '#{StringUtil.swapcase(input)}''")
puts("| Replace vocals by '*':   | '#{StringUtil.censor_small_vocals(input)}'")
puts("| Double consonants with o:| '#{StringUtil.double_consonants_with_o(input)}'")
puts("\n")
puts("Note: Y is interpreted as a consonant")