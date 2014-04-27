module Nacre::Inflectible

  CAMEL_CASE_RE = /(?<=[a-z])[A-Z]/
  SNAKE_CASE_RE = /_(\w)/

  def snake_case(value)
    value.to_s.split(/(?=[A-Z])/).join('_').downcase
  end

  def camelize(value)
    value = value.to_s
    return value unless snake_case?(value)
    value.gsub(/_(\w)/) { $1.upcase }
  end

  def format_hash_keys(value)
    case value
    when Hash
      Hash[value.map { |k, v| [fix_key(k), format_hash_keys(v)] }]
    when Array
      value.map { |v| format_hash_keys(v) }
    else
      value
    end
  end

  def fix_key(key)
    if camel_case?(key)
      snake_case(key).to_sym
    else
      key.downcase.to_sym
    end
  end

  def camel_case?(key)
    CAMEL_CASE_RE === key
  end

  def snake_case?(key)
    SNAKE_CASE_RE === key
  end
end
