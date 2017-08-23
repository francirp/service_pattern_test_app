Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  API_RESOURCES = [
    {
      path: '/',
      type: :user,
      model_name: 'User',
    },
    {
      path: '/',
      type: :event,
      model_name: 'Event',
    },
  ]

  namespace :api do
    namespace :v1 do
      API_RESOURCES.each do |hash|
        type = hash[:type]
        path = hash[:path]
        model_name = hash[:model_name]
        plural_type = type.to_s.pluralize

        get "#{path}#{plural_type}" => ServiceFactory, service: :collect, model_name: model_name, namespace: 'Api'
        get "#{path}#{plural_type}/:id" => ServiceFactory, service: :show, model_name: model_name, namespace: 'Api'
        post "#{path}#{plural_type}" => ServiceFactory, service: :create, model_name: model_name, namespace: 'Api'
        put "#{path}#{plural_type}/:id" => ServiceFactory, service: :update, model_name: model_name, namespace: 'Api'
        delete "#{path}#{plural_type}/:id" => ServiceFactory, service: :destroy, model_name: model_name, namespace: 'Api'
      end
    end
  end
end
