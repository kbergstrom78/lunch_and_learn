Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'recipes', to: 'recipes#search'
      get 'learning_resources', to: 'learning_resources#search'
      post 'users', to: 'users#create'
      post 'sessions', to: 'sessions#create'
      post 'favorites', to: 'favorites#create'
      get 'aqi/:country', to: 'aqi#show'
    end
  end
end