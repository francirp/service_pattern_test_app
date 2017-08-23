class ServiceFactory
  def self.call(env)
    factory = new(env)
    service = factory.build_service
    service.respond
  end

  attr_reader :env, :model_name, :service, :namespace

  def initialize(env)
    @env = env
    path_parameters = env['action_dispatch.request.path_parameters']
    @model_name = path_parameters[:model_name]
    @service = path_parameters[:service]
    @namespace = path_parameters[:namespace]
  end

  def build_service
    service_class.new(env)
  end

  private

  def service_class
    [namespace, model_module, service_class_name].compact.join('::').constantize
  end

  def model_module
    model_name.pluralize
  end

  def service_class_name
    raise 'service is required to be passed into ServiceFactory' unless service.present?
    service.to_s.classify
  end
end