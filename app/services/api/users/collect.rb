module Api
  module Users
    class Collect < CollectService
      def set_resource
        User.all.limit(1)
      end

      def authorized?
        true
      end
    end
  end
end
