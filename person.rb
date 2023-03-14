require_relative 'decorator'
require_relative 'capitalizedecorator'
require_relative 'trimmerdecorator'
require_relative 'basedecorator'

class Person < Nameable
  def initialize(age, person_type, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @person_type = person_type
    @rentals = []
    super()
  end

  attr_accessor :name, :age, :id
  attr_reader :rentals

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
