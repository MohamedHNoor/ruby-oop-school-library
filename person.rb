require_relative 'decorator'
require_relative 'capitalizedecorator'
require_relative 'trimmerdecorator'
require_relative 'basedecorator'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true, person_type: 'student')
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @person_type = person_type
    @rentals = []
    super()
  end

  attr_accessor :name, :age
  attr_reader :id, :rentals

  private

  def of_age?
    @age >= 18
  end

  public

  def can_use_services?
    of_age? || @parent_permission
  end

  def correct_name
    @name
  end

  def rent_book(rental)
    @rentals << rental
  end
end

person = Person.new(22, 'maximilianus')
puts person.correct_name
puts '-------------'
base_decorater_person = BaseDecorator.new(person)
puts base_decorater_person.correct_name
puts '-------------'
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
puts '-------------'
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name
puts '-------------'
