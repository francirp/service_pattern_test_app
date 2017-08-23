class ShowService < ApiService
  include SerializerConcerns

  private

  def response_data
    @resource = object
    serialized_data
  end

  def root_key
    singular_key
  end

  def object
    raise "object method must be implemented in #{self.class.name} class"
  end
end