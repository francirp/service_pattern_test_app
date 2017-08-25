module Defaults
  class Show < ShowService
    def set_resource
      resource_class.find(params[:id])
    end

    def authorized?
      true
    end
  end
end