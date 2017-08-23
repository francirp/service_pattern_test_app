class CreateService < ApiService
  include SerializerConcerns
  include SaveConcerns

  private

  def save
    created_object
  end

  def created_object
    raise "created_object method must be implemented in #{self.class.name} class"
  end

  def root_key
    singular_key
  end
end
