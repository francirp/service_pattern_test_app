module Defaults
  class Collect < CollectService
    def collection
      model.all
    end
  end
end
