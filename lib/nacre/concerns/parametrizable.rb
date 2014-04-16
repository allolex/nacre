module Parametrizable

  def params
    params = {}
    self.class.fields.each do |key|
      value = send(key)
      unless value.nil? || ( value.respond_to?(:params) && value.params.empty? )
        params[key] = value.respond_to?(:params) ? value.params : value
      end
    end
    params
  end

end
