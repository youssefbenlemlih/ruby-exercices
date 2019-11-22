# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg
require_relative './pet'
class Cat < Pet

  def initialize(name, birthday, *persons)
    super(name, birthday,9)
    @personal = persons
    persons.each { |p| p.add_pet(self) if p.is_a?(Person) }
    # TODO: Raise exception if none of *persons is a Person?
  end

  def get_stroke(stroker)
    return false unless @personal.include?(stroker)
    true
  end

  def get_feed(feeder)
    false unless @personal.include?(feeder)
    true
  end

  def special_to_s
    "personal: #{@personal.map { |p| p.name }}"
  end
end
