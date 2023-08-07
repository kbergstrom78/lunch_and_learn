Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'recipes', to: 'recipes#search'
      get 'learning_resources', to: 'learning_resources#search'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#create'
      post 'favorites', to: 'favorites#create'
      get 'air_quality', to: 'air_quality#search'
    end
  end
end