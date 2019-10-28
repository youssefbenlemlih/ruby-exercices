require_relative 'code_breaker'
require_relative 'code_maker'

code_maker = CodeMaker.new
code_breaker = CodeBreaker.new

5.times do
  puts code_breaker.input_code
  puts code_breaker.hits([1,5,6])

end
