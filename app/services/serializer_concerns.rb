module SerializerConcerns
  attr_reader :resource

  private

  def serialized_data
    {
      type: root_key,
      attributes: serialized_attributes
    }
  end

  def root_key
    raise "root_key method must be implemented in #{self.class.name} since it includes SerializerConcerns"
  end

  def serialized_attributes
    return resource unless serialized_resource
    serialized_resource.serializer_instance
  end

  def serialized_resource
    return nil unless Object.const_defined?('ActiveModelSerializers')
    @serialized_resource ||= begin
      ActiveModelSerializers::SerializableResource.new(resource, serializer_options)
    end
  end

  def serializer_options
    {}
  end
end