require_relative 'book'
require_relative 'person'
require_relative 'rental'
require_relative 'student'
require_relative 'teacher'

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def handle_student_input
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    parent_permission = handle_permission
    case parent_permission
    when 'Y'
      parent_permission = true
    when 'N'
      parent_permission = false
    else
      puts 'Invalid selection, please choose from Y or N'
      parent_permission = handle_permission
    end
    student = Student.new(age, name, parent_permission: parent_permission, person_type: 'student')
    @people << student
    puts ['Person created succsefully', ' ']
  end

  def handle_permission
    print 'Has Parent permission? [Y/N]: '
    gets.chomp.capitalize
  end

  def handle_teacher_input
    print 'Age: '
    age = gets.chomp.to_i
    print 'Name: '
    name = gets.chomp.capitalize
    print 'Specialization: '
    specialization = gets.chomp.capitalize
    teacher = Teacher.new(age, name, specialization, person_type: 'teacher')
    @people << teacher
    puts ['Person created successfully', ' ']
  end

  def list_all_people
    @people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end

    puts ['No person on the list', ''] if @people.empty?
  end

  def create_book
    print 'Title: '
    title = gets.chomp.capitalize
    print 'Author: '
    author = gets.chomp.capitalize
    @books << Book.new(title, author)
    puts 'Book created successfully'
  end

  def list_all_books
    @books.each do |book|
      puts "Title: #{book.title}, Author: #{book.author}"
    end

    puts ['No books found on the list', ''] if @books.empty?
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index}) Title: \"#{book.title}\", Author: #{book.author}"
    end
    book_number = gets.chomp.to_i
    book = @books[book_number]

    puts ['', 'Select a person from the following list by number (not id']
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id} Age: #{person.age}"
    end
    person_number = gets.chomp.to_i
    person = @people[person_number]
    puts ''

    print 'Date: '
    date = gets.chomp

    @rentals << Rental.new(date, book, person)
    puts 'Rental created successfully'
  end

  def list_rentals_for_person
    print 'ID of person: '
    person_id = gets.chomp.to_i

    person = @people.find { |p| p.id == person_id }
    if person.nil?
      puts "No person found with id #{person_id}"
      return
    end

    puts 'Rentals: '

    rentals = @rentals.select { |r| r.person.id == person_id }
    if rentals.empty?
      puts "No rentals found for person with id #{person_id}"
      return
    end

    rentals.each do |rental|
      puts "Date: #{rental.date}, Book \"#{rental.book.title}\" by #{rental.person.name}"
    end
  end
end
