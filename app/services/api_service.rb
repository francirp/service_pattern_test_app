class ApiService < ApplicationService
  private

  attr_reader :data, :response_code, :response_data

  def content_type
    'application/json'
  end

  def perform_action
    @response_code = '200'

    run_action = Proc.new do
      @response_data = action
    end

    debug_mode? ? run_action.call : fail_gracefully(run_action)
    @response_data = @response_data.to_json
  end

  def fail_gracefully(proc)
    begin
      proc.call
    rescue StandardError => e
      @response_code = '500'
      @response_data = {
        server_error: e.message
      }
    end
  end

  def debug_mode?
    ENV['SWEET_ACTION_DEBUG_MODE'] == true
  end

  def action
    raise "action method is required for #{self.class.name} because it inherits from ApiService"
  end
end
