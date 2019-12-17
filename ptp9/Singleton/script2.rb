# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

# define a Struct with two attributes
HawPerson = Struct.new(:forename, :lastname) do
  # individual to_s method
  def to_s
    forename + ' ' + lastname + " (#{super})"
  end
end

p HawPerson.singleton_class
p HawPerson.singleton_class.superclass

persons = []
persons << HawPerson.new('Harald', 'Haudegen')
persons << HawPerson.new('Detlef', 'Dompfaff')
persons << HawPerson.new('Knut', 'Kurz')

persons.each do |person|
  # define methods just for this object
  class << person
    def individual
      "individual method called on #{self[:forename]}"
    end
  end
  # alternate strategy to define a method just for this object
  def person.alternate
    "alternate method called on #{self[:forename]}"
  end

  puts "#{person}\n\tsingleton class: " + person.class.singleton_class.inspect
  #p person.singleton_class
  #p person.singleton_class.superclass
  puts "\tsuperclass: " + person.class.singleton_class.superclass.inspect
  puts "\t\tsingleton class for individual method: " + person.individual.singleton_class.inspect
  puts "\t\tsuperclass of individual singleton class: " + person.individual.singleton_class.superclass.inspect
  puts
end

#puts 'Singleton Klasse von BasicObject: ' + BasicObject.singleton_class.inspect
#puts 'Oberklasse von BasicObject: ' + BasicObject.superclass.inspect

