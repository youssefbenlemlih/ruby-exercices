# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative 'consistency'
class PersonError < StandardError;
end
class Person
  include Consistency
  attr_reader :name

  def initialize(name)
    @name = name
    @pets = []
  end

  def add_pet(pet)
    @pets << pet
  end

  def give_service(pet, service)
    raise PersonError, 'A person can only stroke or feed a Pet' unless pet.is_a?(Pet)

    if (service == :feed)
      pet.get_feed(self)
    elsif service == :stroke
      pet.get_stroke(self)
    else
      raise PersonError, "The requested service '#{service}' is not available"
    end
  end

  def to_s
    "#{self.class}: name: #{@name} pets: #{@pets.map { |pet| pet.name }}"
  end

end
