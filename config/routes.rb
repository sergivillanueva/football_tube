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
  
  get "search_by_player" => "search#search_by_player"
  get "search_by_team" => "search#search_by_team"
  
  root 'pages#home'
    
end
