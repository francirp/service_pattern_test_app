module Api
  class RandomAction < ApiService
    def action
      { random: true }
    end
  end
end