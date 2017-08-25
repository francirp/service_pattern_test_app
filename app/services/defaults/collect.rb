module Defaults
  class Collect < CollectService
    def set_resource
      resource_class.all
    end

    def authorized?
      true
    end
  end
end
