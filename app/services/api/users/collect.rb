module Api
  module Users
    class Collect < CollectService
      def set_resource
        User.all.limit(1)
      end

      def authorize

      end
    end
  end
end
