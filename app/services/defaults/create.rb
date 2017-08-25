module Defaults
  class Create < CreateService
    def set_resource
      resource_class.new(resource_params)
    end

    def authorize
    end

    def save
      resource.save
    end
  end
end
