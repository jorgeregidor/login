Rails.application.routes.draw do
 
  root 'pages#home'

  get 'login', to: 'session#new'
  post 'login', to: 'session#create'
  delete 'logout', to: 'session#destroy'

end
