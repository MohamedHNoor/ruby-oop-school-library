require_relative '../student'
require_relative '../classroom'

describe Classroom do
  context 'Checks whether CLassroom class produces intended object output' do
    it 'Initialize a new Classroom and check whether it is an instance of intended class' do
      new_classroom = Classroom.new('A1')
      expect(new_classroom).to be_instance_of Classroom
    end

    it 'Checks add_students? function' do
      new_student = Student.new(25, 'Mert')
      new_classroom = Classroom.new('A1')
      new_classroom.add_students(new_student)
      expect(new_classroom.students).to include(new_student)
    end
  end
end
