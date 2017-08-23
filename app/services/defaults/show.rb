module Defaults
  class Show < ShowService
    def object
      model.find(params[:id])
    end
  end
end
