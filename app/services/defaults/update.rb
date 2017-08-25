module Defaults
  class Update < UpdateService
    def set_resource
      resource_class.find(params[:id])
    end

    def authorize; end

    def save
      resource.update_attributes(resource_params)
    end
  end
end
