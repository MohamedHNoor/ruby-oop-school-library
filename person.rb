require './name_able'
require './decorators'
require './rental'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(id, age, name = 'unknown', parent_permission: true)
    super()
    @id = id
    @age = age
    @name = name
    @parent_permission = parent_permission
    @rentals = []
  end

  def can_use_services?
    of_age? == true || @parent_permission == true
  end

  def correct_name
    @name
  end

  def add_rental(rental)
    @rentals << rental
    rental.person = self
  end

  private

  def of_age?
    @age >= 18
  end
end

# person = Person.new(01, 22, 'maximilianus', parent_permission: false)
# person.correct_name
# capitalized_person = CapitalizeDecorator.new(person)
# p capitalized_person.correct_name
# capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
# p capitalized_trimmed_person.correct_name
# rent = Rental.new('02/02/2023', person, 'Harry Potter')
# rent2 = Rental.new('02/02/2023', person, 'Percy Jackson')

# person.add_rental(rent)
# person.add_rental(rent2)
# p person.rentals

# p person
