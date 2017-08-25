module Api
  class RandomAction < ApiAction
    def action
      { random: true }
    end
  end
end