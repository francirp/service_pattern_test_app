class UpdateService < ApiService
  include SerializerConcerns
  include SaveConcerns

  private

  def save
    updated_object
  end

  def updated_object
    raise "updated_object method must be implemented in #{self.class.name} class"
  end

  def root_key
    singular_key
  end
end
