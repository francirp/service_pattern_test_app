class ApplicationService
  attr_reader :env

  def initialize(env, options = {})
    @env = env
    after_init(options)
  end

  def http_response
    perform_action
    [response_code, response_format, [response_data]]
  end

  private

  def after_init(options); end

  def perform_action
    # hook for subclasses
    # wraps the action
    action
  end

  def action
    # hook for subclasses
    # does majority of the work
  end

  def content_type
    raise "content_type method is required for #{self.class.name} because it inherits from ApplicationService"
  end

  def response_code
    raise "response_code method is required for #{self.class.name} because it inherits from ApplicationService"
  end

  def response_data
    raise "response_data method is required for #{self.class.name} because it inherits from ApplicationService"
  end

  def response_format
    { 'Content-Type' => content_type }
  end

  def path_parameters
    @path_parameters ||= env['action_dispatch.request.path_parameters']
  end

  def request
    @request ||= Rack::Request.new(env)
  end

  def body
    @body ||= begin
      json = request.body.read
      return {} unless json.present?
      raw_body = JSON.parse(json)
      raw_body.is_a?(Hash) ? raw_body.with_indifferent_access : {}
    end
  end

  def query_string_params
    @query_string_params ||= request.params.with_indifferent_access
  end

  def params
    @params ||= query_string_params.merge(body).merge(path_parameters)
  end
end
