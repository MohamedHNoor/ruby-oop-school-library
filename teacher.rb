require './person'

class Teacher < Person
  def initialize(id, age, specialization, name = 'unknown')
    super(id, age, name, parent_permission: true)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
