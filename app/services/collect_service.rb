class CollectService < ApiService
  include SerializerConcerns

  private

  def response_data
    @resource = collection
    serialized_data
  end

  def root_key
    plural_key
  end

  def collection
    raise "collection method must be implemented in #{self.class.name} class"
  end
end
