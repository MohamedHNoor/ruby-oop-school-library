class Rental
  attr_accessor :date
  attr_reader :book

  def initialize(date, person, book)
    @date = date
    @person = person
    @book = book
  end

  def book=(book)
    @book = book
    book.rentals << self unless book.rentals.include?(self)
  end

  def person=(person)
    @person = person
    person.rentals << self unless person.rentals.include?(self)
  end
end
