class ApplicationService
  attr_reader :env, :path_parameters, :request, :body, :query_string_params,
              :params, :model_name

  def initialize(env)
    @env = env
    @path_parameters = env['action_dispatch.request.path_parameters']
    @request = Rack::Request.new(env)
    @body = pull_body
    @query_string_params = request.params.with_indifferent_access
    @params = query_string_params.merge(body).merge(path_parameters)
    @model_name = path_parameters[:model_name]
    require_args
    after_init
  end

  def respond
    # default hook for subclasses
    [response_code, response_format, [response]]
  end

  private

  def after_init
    # hook
  end

  def response_code
    @response_code ||= '200'
  end

  def response_format
    { 'Content-Type' => content_type }
  end

  def response_data
    'ok'
  end

  def response
    response_data
  end

  def content_type
    'text/html'
  end

  def require_args
    raise "model argument is required for #{self.class.name}" unless model.present?
  end

  def model
    model_name.constantize
  end

  def model_decanter
    @model_decanter ||= "#{model.to_s.classify}Decanter".constantize
  end

  def model_params
    @model_params ||= model_decanter.decant(params[singular_key])
  end

  def plural_key
    model.name.underscore.pluralize
  end

  def singular_key
    model.name.underscore
  end

  def pull_body
    json = request.body.read
    return {} unless json.present?
    raw_body = JSON.parse(json)
    raw_body.is_a?(Hash) ? raw_body.with_indifferent_access : {}
  end
end
