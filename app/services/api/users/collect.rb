module Api
  module Users
    class Collect < CollectService
      def collection
        User.all
      end
    end
  end
end
