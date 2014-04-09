module Parametrizable

  def params
    params = {}
    self.class.fields.each do |key|
      params[key] = if self.send(key).respond_to?(:params)
                      self.send(key).params
                    else
                      self.send(key)
                    end
    end
    params
  end

end
