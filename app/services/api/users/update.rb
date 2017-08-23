module Api
  module Users
    class Update < UpdateService
      def updated_object
        user = User.find(params[:id])
        user.update_attributes(model_params)
        user
      end
    end
  end
end
