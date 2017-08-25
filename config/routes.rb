SWEET_ACTION_RESOURCES = [
  {
    path: '/',
    type: :user,
    resource_name: 'User',
  },
  {
    path: '/',
    type: :event,
    resource_name: 'Event',
  },
]

def create_sweet_actions(hash)
  type = hash[:type]
  path = hash[:path]
  resource_name = hash[:resource_name]
  plural_type = type.to_s.pluralize

  get "#{path}#{plural_type}" => ServiceFactory, service: :collect, resource_name: resource_name, namespace: 'Api'
  get "#{path}#{plural_type}/:id" => ServiceFactory, service: :show, resource_name: resource_name, namespace: 'Api'
  post "#{path}#{plural_type}" => ServiceFactory, service: :create, resource_name: resource_name, namespace: 'Api'
  put "#{path}#{plural_type}/:id" => ServiceFactory, service: :update, resource_name: resource_name, namespace: 'Api'
  delete "#{path}#{plural_type}/:id" => ServiceFactory, service: :destroy, resource_name: resource_name, namespace: 'Api'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      SWEET_ACTION_RESOURCES.each do |hash|
        create_sweet_actions(hash)
      end
      get '/test' => ServiceFactory, service: :test, namespace: 'Api'
    end
  end
end
