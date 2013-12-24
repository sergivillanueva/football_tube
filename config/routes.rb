FootballTube::Application.routes.draw do
  resources :matches
  resources :teams do
    get "search", on: :collection
  end
  resources :players do
    get "search", on: :collection
  end
  resources :competitions do
    get "search", on: :collection
  end
  
  root 'teams#new'
    
end
