FootballTube::Application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
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

  get "profile/:id" => "profiles#show", as: :profile

  get "search_by_player" => "search#search_by_player"
  get "search_by_team" => "search#search_by_team"
  get "search_by_competition" => "search#search_by_competition"
  get "search_head_to_head" => "search#search_head_to_head"
  get "advanced_search" => "search#advanced_search", as: :advanced_search
  
  root 'pages#home'
    
end
