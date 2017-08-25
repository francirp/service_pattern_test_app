module Defaults
  class Destroy < DestroyService
    def destroyed_object
      object = resource_class.find(params[:id])
      object.destroy
      object
    end
  end
end
