module Api
  module Users
    class Collect < CollectAction
      def set_resource
        User.all.limit(1)
      end

      def authorized?
        true
      end
    end
  end
end
