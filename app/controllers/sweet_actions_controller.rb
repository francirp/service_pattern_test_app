class SweetActionsController < ApplicationController
  def action_missing(action_name)
    factory = ServiceFactory.new(self, action_name)
    service = factory.build_service
    service.perform_action
    render status: service.response_code, json: service.response_data
  end
end