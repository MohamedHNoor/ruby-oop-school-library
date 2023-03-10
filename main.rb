require './app'

def instructions
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List all rentals for a give person id'
  puts '7 - Exit'
end

class User
  def initialize
    @app = App.new
  end

  def case1
    @app.books
    puts ''
    instructions
    user_input
  end

  def case2
    @app.people
    puts ''
    instructions
    user_input
  end

  def case3
    print 'Do you want to create a student(1) or a teacher(2)? [input the number]: '
    option = gets.chomp
    @app.person(option)
    puts ''
    instructions
    user_input
  end

  def case4
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @app.book(title, author)
    puts ''
    instructions
    user_input
  end

  def case5
    puts 'Select a book from the following list by number'
    @app.show_books
    index = gets.chomp
    book = @app.show_book(index.to_i)
    puts 'Select a person from the following list by number (not ID)'
    @app.show_people
    index_p = gets.chomp
    person = @app.show_person(index_p.to_i)
    print 'Date: '
    date = gets.chomp
    @app.rental(date, person, book)
    puts ''
    instructions
    user_input
  end

  def case6
    print 'ID of person: '
    id = gets.chomp
    @app.rentals(id.to_i)
    puts ''
    instructions
    user_input
  end

  def user_input
    input = gets.chomp
    case input
    when '1'
      case1
    when '2'
      case2
    when '3'
      case3
    when '4'
      case4
    when '5'
      case5
    when '6'
      case6
    else
      puts 'Thank you for using this app'
    end
  end
end

def main
  instructions
  user = User.new
  user.user_input
end

main
