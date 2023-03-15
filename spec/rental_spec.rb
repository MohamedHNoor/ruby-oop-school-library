require_relative '../book'
require_relative '../rental'
require_relative '../student'

describe Book do
  context 'Checks whether class Rental produces intended object output' do
    it 'Initialize a new Rental and check whether it is an instance of intended class' do
      person = Student.new(23, 'Trust', parent_permission: true)
      book = Book.new('Outliers', 'Malcolm Gladwell')
      new_rental = Rental.new('2022/09/02', book, person)
      expect(new_rental).to be_instance_of Rental
    end

    it 'Checks if a rental contains a person' do
      person = Student.new(23, 'Trust', parent_permission: true)
      book = Book.new('Outliers', 'Malcolm Gladwell')
      new_rental = Rental.new('2022/05/01', book, person)
      expect(new_rental.person).to eq(person)
    end

    it 'Checks if a book contains a rental' do
      person = Student.new(23, 'Trust', parent_permission: true)
      book = Book.new('Outliers', 'Malcolm Gladwell')
      new_rental = Rental.new('2022/05/01', book, person)
      expect(book.rentals[0]).to eq(new_rental)
    end
  end
end
