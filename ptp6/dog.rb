# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative './pet'
class Dog < Pet

  def initialize(name, birthday, person)
    super(name, birthday,1)
    @owner = person if person.is_a?(Person) # TODO: Raise exception if person is not a Person?
    person.add_pet(self)
  end

  def special_to_s
    "owner: #{@owner.name}"
  end
end