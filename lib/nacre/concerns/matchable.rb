module Matchable

  def blank?(value)
    value.nil? || matches?(value,'\s*')
  end

  def matches?(value,subexpression)
    /\A#{subexpression}\z/i === value
  end

end
