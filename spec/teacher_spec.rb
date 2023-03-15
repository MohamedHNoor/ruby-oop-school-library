require_relative '../teacher'

describe Teacher do
  context 'Checks whether Teacher class produces intended object output' do
    it 'Initialize a new Teacher and check whether it is an instance of intended class' do
      new_teacher = Teacher.new(45, 'Mathematics', 'Wassim', parent_permission: true)
      expect(new_teacher).to be_instance_of Teacher
    end

    it 'Checks can_use_services? function' do
      new_teacher = Teacher.new(64, 'Philosophy', 'Simeon')
      expect(new_teacher.can_use_services?).to be_truthy
    end
  end
end
