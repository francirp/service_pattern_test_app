module SaveConcerns
  def response_data
    @resource ||= save
    return failure if errors?
    success
  end

  def save
    raise "save method must be implemented for #{self.class.name} class since it includes SaveConcerns"
  end

  def success
    serialized_data
  end

  def failure
    @response_code = '422'

    {
      errors: {
        singular_key => map_base_to__error(resource.errors.messages)
      }
    }
  end

  def map_base_to__error(error_obj)
    error_obj[:_error] = error_obj.delete(:base) if error_obj.key? :base
    error_obj
  end

  def errors?
    resource.respond_to?(:errors) && resource.errors.any?
  end
end
