# Author:: Youssef Benlemlih
# Author:: Jonas Krukenberg

HawPerson = Struct.new(:forename, :lastname) do
  def to_s
    forename + ' ' + lastname + " (#{super})"
  end
end

persons = []
persons << HawPerson.new('Harald', 'Haudegen')
persons << HawPerson.new('Detlef', 'Dompfaff')
persons << HawPerson.new('Knut', 'Kurz')

persons.each do |person|
  class << person
    def individual
      "individual method called on #{self}"
    end
  end

  puts "#{person}\n\tsingleton class: " + person.singleton_class.inspect
  puts "\tsuperclass: " + person.singleton_class.superclass.inspect
  puts "\tsingleton class for individual method: #{person.individual.singleton_class.inspect}"
end

puts "\nSingleton Klasse von BasicObject: #{BasicObject.singleton_class.inspect}"
puts "Oberklasse von BasicObject: #{BasicObject.superclass.inspect}"

