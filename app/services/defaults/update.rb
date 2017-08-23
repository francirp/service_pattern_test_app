module Defaults
  class Update < UpdateService
    def updated_object
      object = model.find(params[:id])
      object.update_attributes(model_params)
      object
    end
  end
end
