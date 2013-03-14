Avalon::Application.routes.draw do
  root :to => 'home#home'
  
  # Directories
  get    '(/*path)/directories'     => 'directories#index'
  get    '(/*path)/directories/new' => 'directories#new'
  post   '(/*path)/directories'     => 'directories#create'
  get    '(/*path)/edit'            => 'directories#edit'
  put    '/*path'                   => 'directories#update'
  delete '/*path'                   => 'directories#destroy'
  get    '*path'                    => 'directories#show'
end # routes
