if Rails.env.development?
  lib_ruby_files = Dir.glob(File.join('app/**', '*.rb'))
  lib_reloader ||= ActiveSupport::FileUpdateChecker.new(lib_ruby_files) do
    Rails.application.reload_routes!
    # lib_ruby_files.each do |lib_file|
    #  silence_warnings { require_dependency(lib_file) }
    # end
  end

  ActionDispatch::Callbacks.to_prepare do
    lib_reloader.execute_if_updated
  end
end

# def create_sweet_actions(resource, options = {})
#   path = options.fetch(:path, '/')
#   namespace = options.fetch(:namespace, nil)
#   singular = resource.to_s.singularize
#   resource_class = singular.classify

#   options = options.merge(resource_name: resource_class, namespace: namespace)

#   get "#{path}#{resource}", { to: ServiceFactory, service: :collect }.merge(options)
#   get "#{path}#{resource}/:id", { to: ServiceFactory, service: :show }.merge(options)
#   post "#{path}#{resource}", { to: ServiceFactory, service: :create }.merge(options)
#   put "#{path}#{resource}/:id", { to: ServiceFactory, service: :update }.merge(options)
#   delete "#{path}#{resource}/:id", { to: ServiceFactory, service: :destroy }.merge(options)
# end

def create_sweet_actions(resource, options = {})
  path = options.fetch(:path, '/')
  namespace = options.fetch(:namespace, nil)
  singular = resource.to_s.singularize
  resource_class = singular.classify

  options = options.merge(resource_name: resource_class, namespace: namespace)

  get "#{path}#{resource}", { to: 'sweet_actions#collect' }.merge(options)
  get "#{path}#{resource}/:id", { to: 'sweet_actions#show' }.merge(options)
  post "#{path}#{resource}", { to: 'sweet_actions#create' }.merge(options)
  put "#{path}#{resource}/:id", { to: 'sweet_actions#update' }.merge(options)
  delete "#{path}#{resource}/:id", { to: 'sweet_actions#destroy' }.merge(options)
end
