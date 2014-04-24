module Inflectible

  def snake_case(value)
    value.to_s.split(/(?=[A-Z])/).join('_').downcase
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
    Nacre::CAMEL_CASE_RE === key
  end
end
