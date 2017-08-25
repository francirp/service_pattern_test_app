module RestSerializerConcerns
  private

  def root_key
    raise "root_key method must be implemented in #{self.class.name} since it includes RestSerializerConcerns"
  end

  def serialize
    return serialize_destroyed_resource if destroyed?

    {
      type: root_key,
      attributes: serialized_attributes
    }
  end

  def serialize_destroyed_resource
    { root_key => {} }
  end

  def serialize_errors
    {
      errors: {
        singular_key => map_base_to__error(errors.messages)
      }
    }
  end

  def errors
    resource.respond_to?(:errors) && resource.errors
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

  def destroyed?
    resource.respond_to?(:destroyed?) && resource.destroyed?
  end
end