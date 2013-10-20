FootballTube::Application.routes.draw do
  resources :matches
  resources :teams
  
  root 'teams#new'
end
