require './student'
require './teacher'
require './book'
require './rental'

class App
  def initialize
    @people_list = []
    @book_list = []
  end

  def books
    if @book_list.empty?
      puts ''
    else
      @book_list.each do |book|
        res = "Title: #{book.title}, Author: #{book.author}"
        puts res
      end
    end
  end

  def people
    if @people_list.empty?
      puts ''
    else
      @people_list.each do |person|
        case person[0]
        when 'Student'
          res = "[Student] Name: #{person[1].name}, ID: #{person[1].id}, Age: #{person[1].age}"
          puts res
        when 'Teacher'
          res = "[Teacher] Name: #{person[1].name}, ID: #{person[1].id}, Age: #{person[1].age}"
          puts res
        end
      end
    end
  end

  def add_books(book)
    @book_list << book
  end

  def add_people(person)
    @people_list << person
  end

  def check_permission(lower)
    case lower
    when 'y'
      true
    when 'n'
      false
    else
      puts 'invalid option'
      nil
    end
  end

  def person1
    id = rand(1..1000)
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Has parent permission? [Y/N]: '
    permission = gets.chomp
    lower = permission.downcase
    bool = check_permission(lower)
    classroom = 'unknown'
    student = Student.new(id, age, classroom, name, parent_permission: bool)
    person = []
    person.push('Student')
    person.push(student)
    add_people(person)
    puts 'Person created successfully'
  end

  def person(option)
    case option
    when '1'
      person1
    when '2'
      id = rand(1..1000)
      print 'Age: '
      age = gets.chomp
      print 'Name: '
      name = gets.chomp
      print 'Specialization: '
      specialization = gets.chomp
      teacher = Teacher.new(id, age, specialization, name)
      person = []
      person.push('Teacher')
      person.push(teacher)
      add_people(person)
      puts 'Person created successfully'
    else
      puts 'Invalid option'
    end
  end

  def book(title, author)
    book = Book.new(title, author)
    add_books(book)
    puts 'Book created successfully'
  end

  def rental(date, person, book)
    rental = Rental.new(date, person, book)
    rental.book = book
    rental.person = person
    puts 'Rental created successfully'
  end

  def rentals(id)
    person = @people_list.find { |item| item[1].id == id }
    rental = person[1].rentals
    rental.each do |item|
      puts "Date: #{item.date}, Book: \"#{item.book.title}\" by #{item.book.author}"
    end
  end

  def show_books
    if @book_list.empty?
      puts ''
    else
      @book_list.each_with_index do |book, index|
        res = "#{index}) Title: #{book.title}, Author: #{book.author}"
        puts res
      end
    end
  end

  def show_people
    if @people_list.empty?
      puts ''
    else
      @people_list.each_with_index do |person, index|
        case person[0]
        when 'Student'
          res = "#{index} [Student] Name: #{person[1].name}, ID: #{person[1].id}, Age: #{person[1].age}"
          puts res
        when 'Teacher'
          res = "#{index} [Teacher] Name: #{person[1].name}, ID: #{person[1].id}, Age: #{person[1].age}"
          puts res
        end
      end
    end
  end

  def show_person(index)
    if @book_list.empty?
      puts 'Add person first'
      return
    end
    @people_list[index][1]
  end

  def show_book(index)
    if @book_list.empty?
      puts 'Add book first'
      return
    end
    @book_list[index]
  end
end
