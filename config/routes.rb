Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/api' do
    scope '/v1' do
      create_sweet_actions(:users, namespace: 'Api')
      create_sweet_actions(:events, namespace: 'Api')
      get '/random-action', to: 'sweet_actions#random_action', namespace: 'Api'
    end
  end
end
