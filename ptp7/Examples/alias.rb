class Pet
  def info
    "called from Pet!"
  end

  def self.set_aliases
    # calls info on self determined at runtime
    alias_method :alias_method_info, :info
    # calls info on self at the time the source code is read (here: this class Pet)
    alias alias_info info
  end
end

class Dog < Pet
  def info
    "called from Dog!"
  end
  set_aliases
end

puts Dog.new.alias_method_info + " (alias_method)"
puts Dog.new.alias_info + " (alias)"
