class DestroyService < ApiService
  def response_data
    destroyed_object
  end

  def destroyed_object
    raise "destroyed_object method must be implemented in #{self.class.name} class"
  end
end
