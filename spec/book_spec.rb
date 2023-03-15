require_relative '../book'
require_relative '../rental'
require_relative '../student'

describe Book do
  context 'Checks whether Book class produces intended object output' do
    it 'Initialize a new Book and check whether it is an instance of intended class' do
      new_book = Book.new('Outliers', 'Malcolm Gladwell')
      expect(new_book).to be_instance_of Book
    end

    it 'Checks if a book contains a rental' do
      person = Student.new(23, 'Wassim', parent_permission: true)
      new_book = Book.new('Outliers', 'Malcolm Gladwell')
      new_rental = Rental.new('2022/05/01', new_book, person)
      new_book.add_rental(new_rental)
      expect(new_book.rentals[0].date).to eq('2022/05/01')
    end
  end
end
