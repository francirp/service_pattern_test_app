module Api
  module Users
    class Destroy < DestroyService
      def destroyed_object
        user = User.find(params[:id])
        user.destroy
        user
      end
    end
  end
end