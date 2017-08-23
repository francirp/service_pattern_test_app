module Defaults
  class Destroy < DestroyService
    def destroyed_object
      object = model.find(params[:id])
      object.destroy
      object
    end
  end
end
