module Parametrizable

  def params
    params = {}
    self.class.fields.each do |key|
      params[key] = if send(key).respond_to?(:params)
                      send(key).params
                    else
                      send(key)
                    end
    end
    params
  end

end
