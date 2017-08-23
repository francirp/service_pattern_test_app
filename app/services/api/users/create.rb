module Api
  module Users
    class Create < CreateService
      def created_object
        User.create(model_params)
      end
    end
  end
end