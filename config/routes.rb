Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  API_RESOURCES = [
    {
      path: '/',
      type: :user,
      model_name: 'User',
    }
  ]

  namespace :api do
    namespace :v1 do
      API_RESOURCES.each do |hash|
        type = hash[:type]
        path = hash[:path]
        model_name = hash[:model_name]
        plural_type = type.to_s.pluralize
        module_name = type.to_s.classify.pluralize
        # service_namespace = "Api::#{module_name}"

        # get "#{path}#{plural_type}" => "#{service_namespace}::Collect".constantize, model_name: model_name
        # get "#{path}#{plural_type}/:id" => "#{service_namespace}::Show".constantize, model_name: model_name
        # post "#{path}#{plural_type}" => "Api::#{module_name}::Create".constantize, model_name: model_name
        # put "#{path}#{plural_type}/:id" => "#{service_namespace}::Update".constantize, model_name: model_name
        # delete "#{path}#{plural_type}/:id" => "#{service_namespace}::Destroy".constantize, model_name: model_name

        get "#{path}#{plural_type}" => ServiceFactory, service: :collect, model_name: model_name, namespace: 'Api'
        get "#{path}#{plural_type}/:id" => ServiceFactory, service: :show, model_name: model_name, namespace: 'Api'
        post "#{path}#{plural_type}" => ServiceFactory, service: :create, model_name: model_name, namespace: 'Api'
        put "#{path}#{plural_type}/:id" => ServiceFactory, service: :update, model_name: model_name, namespace: 'Api'
        delete "#{path}#{plural_type}/:id" => ServiceFactory, service: :destroy, model_name: model_name, namespace: 'Api'
      end
    end
  end
end
