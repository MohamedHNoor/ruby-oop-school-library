require_relative '../person'

describe Person do
  context 'Checks whether Person class produces intended object output' do
    it 'Initialize a new Person and check whether it is an instance of intended class' do
      new_person = Person.new(23, 'Teacher', 'Mert', parent_permission: true)
      expect(new_person).to be_instance_of Person
    end

    it 'Checks can_use_services? function' do
      new_person = Person.new(39, 'Student', 'Mehmet', parent_permission: true)
      expect(new_person.can_use_services?).to be_truthy
    end

    it 'Checks correct_name function' do
      new_person = Person.new(25, 'Teacher', 'Selin', parent_permission: true)
      expect(new_person.correct_name).to eq('Selin')
    end
  end
end
