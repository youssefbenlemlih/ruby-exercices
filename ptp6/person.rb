class Person
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def to_s
    "#{self.class}: name: #{@name} pets: #{@pets.map {|pet| pet.name}}"
  end
end