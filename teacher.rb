require './person'

class Teacher < Person
  def initialize(age, specialization, name = 'Unknown', parent_permission: true, person_type: 'student')
    super(age, name, parent_permission: parent_permission, person_type: person_type)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
