class SweetActionsController < ApplicationController
  def action_missing(action_name)
    factory = ActionFactory.new(self, action_name)
    action = factory.build_action
    action.perform_action
    render status: action.response_code, json: action.response_data
  end
end