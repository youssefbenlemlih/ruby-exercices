require_relative './pet'
class Cat < Pet

  def initialize(name, birthday, *persons)
    super(name, birthday,9)
    @personal = persons
    persons.each { |p| p.add_pet(self) }
  end

  def special_to_s
    "personal: #{@personal.map { |p| p.name }}"
  end
end