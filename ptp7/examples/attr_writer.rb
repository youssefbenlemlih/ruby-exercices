# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# Example class to demonstrate risks when using attr_writer
class Example

  attr_writer :references, :locked

  def initialize(name, content)
    @name = name
    @content = content
    @locked = true
    # Error may be prevented by defining @references with an optional default value
    # @references = []
  end

  def references_list
    # This throws an error because @references is not defined as an array
    @references.join(', ')
  end

  def update_content(new)
    @content = new unless @locked
  end
end

ex = Example.new('Beispiel2', 'describing example text...')
p ex
# unlock the Example
ex.locked = false
ex.update_content('malicious text')
p ex
# This throws an error
puts ex.references_list