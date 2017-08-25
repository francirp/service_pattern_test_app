module Defaults
  class Show < ShowService
    def set_resource
      resource_class.find(params[:id])
    end

    def authorize
      # can?(:read, resource)
    end
  end
end