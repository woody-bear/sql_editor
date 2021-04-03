Rails.application.routes.draw do
  # get 'sql_editor', to: 'sql_editor#index'
  post 'sql_editor', to: 'sql_editor#index'
  get 'sql_editor/query', to: 'sql_editor#query'
  
  root 'post#index'
  namespace :user do
    get 'login'
    post 'signin'
    post 'logout'

  end

  resources :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
