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

  # Direct search routes

  PLAYER_MARADONA_ID = 1685
  PLAYER_DI_STEFANO_ID = 196
  PLAYER_CRUYFF_ID = 730
  PLAYER_PELE_ID = 135
  PLAYER_MESSI_ID = 4732

  TEAM_NETHERLANDS_ID = 83
  TEAM_BRAZIL_ID = 12
  TEAM_AC_MILAN_ID = 26  
  TEAM_FC_BARCELONA_ID = 21
  TEAM_REAL_MADRID_ID = 16
  TEAM_SPAIN_ID = 14
  TEAM_FRANCE_ID = 11

  %w(maradona di_stefano cruyff pele messi).each do |name|
    get "/#{name}-matches" => "search#search_by_player", player_id: eval("PLAYER_#{name.upcase}_ID"), as: "search_for_#{name}"
  end

  get "/clockwork-orange-matches" => "search#search_by_team", team_id: TEAM_NETHERLANDS_ID, from_year: 1974, to_year: 1978, term: "Clockwork orange", as: "search_for_clockwork_orange"
  get "/brazil-70-matches" => "search#search_by_team", team_id: TEAM_BRAZIL_ID, from_year: 1970, to_year: 1970, term: "Brazil '70", as: "search_for_brazil_70"
  get "/dream-team-matches" => "search#search_by_team", team_id: TEAM_FC_BARCELONA_ID, from_year: 1990, to_year: 1994, term: "Dream Team", as: "search_for_dream_team"
  get "/quinta-del-buitre-matches" => "search#search_by_team", team_id: TEAM_REAL_MADRID_ID, from_year: 1985, to_year: 1990, term: "La Quinta del Buitre", as: "search_for_quinta_del_buitre"
  get "/sacchi-milan-matches" => "search#search_by_team", team_id: TEAM_AC_MILAN_ID, from_year: 1987, to_year: 1992, term: "Sacchi Milan", as: "search_for_sacchi_milan"
  get "/france-80s-matches" => "search#search_by_team", team_id: TEAM_FRANCE_ID, from_year: 1982, to_year: 1986, term: "France 80's", as: "search_for_france_80s"
  get "/spain-08-12-matches" => "search#search_by_team", team_id: TEAM_SPAIN_ID, from_year: 2008, to_year: 2012, term: "Spain 2008-2012", as: "search_for_spain_08_12"

  get "/el-clasico-matches" => "search#search_head_to_head", team_one_id: TEAM_FC_BARCELONA_ID, team_two_id: TEAM_REAL_MADRID_ID, term: "El Clásico", as: "search_for_el_clasico"
      
end
