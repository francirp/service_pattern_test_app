module Api
  module Users
    class Show < ShowService
      def object
        User.find(params[:id])
      end
    end
  end
end