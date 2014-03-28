module Matchable

  def blank?(value)
    value.nil? || matches?(value,'\s*')
  end

  def matches?(value,subexpression)
    !! ( value =~ /\A#{subexpression}\z/i )
  end

end
