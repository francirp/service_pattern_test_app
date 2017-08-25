class ServiceFactory
  attr_reader :controller, :resource_name, :service, :namespace

  def initialize(controller, service_name)
    @controller = controller
    path_parameters = env['action_dispatch.request.path_parameters']
    @resource_name = path_parameters[:resource_name]
    @service = service_name
    @namespace = path_parameters[:namespace]
  end

  def build_service
    service_class.new(controller)
  end

  private

  def env
    controller.request.env
  end

  def service_class
    klass_name = [namespace, resource_module, service_class_name].compact.join('::')
    return klass_name.constantize if klass_defined?(klass_name)
    default_service
  end

  def resource_module
    return nil unless resource_name
    resource_name.pluralize
  end

  def service_class_name
    raise 'service is required to be passed into ServiceFactory' unless service.present?
    service.to_s.classify
  end

  def default_service
    modules = namespace.split('::')
    class_found = false
    klass_name = "Defaults::#{service_class_name}"

    until class_found || modules.count == 0
      namespace_to_test = modules.join('::')
      target = "#{namespace_to_test}::Defaults::#{service_class_name}"
      if klass_defined?(target)
        klass_name = target
        class_found = true
      end
      modules.pop
    end
    klass_name.constantize
  end

  def klass_defined?(klass_name)
    klass_name.constantize
    return true
  rescue
    return false
  end
end
