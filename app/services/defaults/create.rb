module Defaults
  class Create < CreateService
    def created_object
      model.create(model_params)
    end
  end
end
