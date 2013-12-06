FootballTube::Application.routes.draw do
  resources :matches
  resources :teams do
    get "search", on: :collection
  end
  resources :players, only: [] do
    get "search", on: :collection
  end
  
  root 'teams#new'
    
end
