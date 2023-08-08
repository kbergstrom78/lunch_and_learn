Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'recipes', to: 'recipes#search'
      get 'learning_resources', to: 'learning_resources#search'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#create'
      post 'favorites', to: 'favorites#create'
      get 'favorites', to: 'favorites#index'
    end
  end
end