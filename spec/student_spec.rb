require_relative '../student'
require_relative '../classroom'

describe Student do
  context 'Checks whether Student class produces intended object output' do
    it 'Initialize a new Student and check whether it is an instance of intended class' do
      new_student = Student.new(16, 'Mert', parent_permission: false)
      expect(new_student).to be_instance_of Student
    end

    it 'Checks classroom? function' do
      new_student = Student.new(25, 'Simeon', parent_permission: true)
      classroom1 = Classroom.new('A1')
      new_student.classroom = classroom1
      expect(new_student.classroom).to be(classroom1)
    end
  end
end
