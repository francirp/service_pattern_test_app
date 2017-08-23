class ApiService < ApplicationService
  private

  def content_type
    'application/json'
  end

  def response
    response_data.to_json
  end
end
