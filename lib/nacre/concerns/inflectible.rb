module Inflectible

  def snake_case(value)
    value.split(/(?=[A-Z])/).join('_').downcase
  end

end
