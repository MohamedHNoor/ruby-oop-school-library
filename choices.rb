require_relative 'preserve_data'

def create_person
  print 'Do you want to create a student (1) or a teacher (2)? '
  print '[Input the number]: '
end

def display_options
  puts 'Please choose an option by entering a number:'
  puts '1 - List all books'
  puts '2 - List all people'
  puts '3 - Create a person'
  puts '4 - Create a book'
  puts '5 - Create a rental'
  puts '6 - List rentals for a given person id'
  puts '7 - Exit'
end

def check_options(app)
  input = nil
  until input == 7
    display_options
    input = gets.to_i
    puts 'Invalid choice, please select a number from [1..7]' if input < 1 || input > 7
    input_process(input, app)
  end

  write_data('books', app.books)
  write_data('people', app.people)
  write_data('rentals', app.rentals)
end

def person_choice(choice, app)
  case choice
  when 1
    app.handle_student_input
  when 2
    app.handle_teacher_input
  else
    puts 'Invalid choice, please select a number from [1..2]'
    choice = gets.to_i
    person_choice(choice, app)
  end
end

def input_process(input, app)
  case input
  when 1
    app.list_all_books
  when 2
    app.list_all_people
  when 3
    create_person
    choice = gets.to_i
    person_choice(choice, app)
  when 4
    app.create_book
  when 5
    app.create_rental
  when 6
    app.list_rentals_for_person
  end
end

def welcome_message
  app = App.new
  puts ['Welcome to School Library App!', '']
  app
end
