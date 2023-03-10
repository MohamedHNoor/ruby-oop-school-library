require './decorator'

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    value = @nameable.correct_name
    value.strip
    if value.length <= 10
      value
    else
      value[0..9]
    end
  end
end
