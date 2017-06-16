FootballTube::Application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'
  devise_for :users
  localized do
    resources :matches do
      get :preview_image, on: :member
      get :mini_preview_image, on: :member
      post :increment_visualizations_counter, on: :member
      post :publish, on: :member
      resources :comments
    end
    resources :teams do
      get "search", on: :collection
    end
    resources :players do
      get "search", on: :collection
    end
    resources :competitions do
      get "search", on: :collection
    end
    resources :videos, only: [:index, :destroy]
    resources :contacts, only: [:new, :create]
    resources :rates, only: [:index], controller: :rater
    resources :goals, only: [] do
      post "set_video_start_position"
      post "set_video_end_position"
      post "toggle_kind"
      post "set_video_id"
    end
    resources :users, only: [:index]

    get "/profile/:id" => "profiles#show", as: :profile

    get "/search_by_player" => "search#search_by_player"
    get "/search_by_team" => "search#search_by_team"
    get "/search_head_to_head" => "search#search_head_to_head"
    get "/advanced_search" => "search#advanced_search", as: :advanced_search
    get "/about" => "pages#about", as: :about
    get "/contact" => "pages#contact", as: :contact
    get "/privacy_policy" => "pages#privacy_policy", as: :privacy_policy
    get "/paypal_donation_ok" => "pages#paypal_donation_ok"
    get "/paypal_donation_ko" => "pages#paypal_donation_ko"
    get "/" => "pages#home", as: :home
  end

  root 'pages#home'

  # Direct search routes

  TEAM_NETHERLANDS_ID = 83
  TEAM_BRAZIL_ID = 12
  TEAM_AC_MILAN_ID = 26  
  TEAM_FC_BARCELONA_ID = 21
  TEAM_REAL_MADRID_ID = 16
  TEAM_SPAIN_ID = 14
  TEAM_FRANCE_ID = 11
  WORLD_CUP_ID = 4
  CHAMPIONS_LEAGUE_ID = 1
  COPA_LIBERTADORES_ID = 7
  EUROPEAN_CUP_ID = 5

  localized do
    get "/clockwork-orange-matches" => "teams#show", id: TEAM_NETHERLANDS_ID, from_year: 1974, to_year: 1978, term: I18n.t("pages.special_matches.clockwork_orange"), as: "search_for_clockwork_orange"
    get "/brazil-70-matches" => "teams#show", id: TEAM_BRAZIL_ID, from_year: 1970, to_year: 1970, term: I18n.t("pages.special_matches.brazil_70"), as: "search_for_brazil_70"
    get "/dream-team-matches" => "teams#show", id: TEAM_FC_BARCELONA_ID, from_year: 1990, to_year: 1994, term: I18n.t("pages.special_matches.dream_team"), as: "search_for_dream_team"
    get "/quinta-del-buitre-matches" => "teams#show", id: TEAM_REAL_MADRID_ID, from_year: 1985, to_year: 1990, term: I18n.t("pages.special_matches.quinta_del_buitre"), as: "search_for_quinta_del_buitre"
    get "/sacchi-milan-matches" => "teams#show", id: TEAM_AC_MILAN_ID, from_year: 1987, to_year: 1992, term: I18n.t("pages.special_matches.sacchi_milan"), as: "search_for_sacchi_milan"
    get "/france-80s-matches" => "teams#show", id: TEAM_FRANCE_ID, from_year: 1982, to_year: 1986, term: I18n.t("pages.special_matches.france_80s"), as: "search_for_france_80s"
    get "/spain-08-12-matches" => "teams#show", id: TEAM_SPAIN_ID, from_year: 2008, to_year: 2012, term: I18n.t("pages.special_matches.spain_08_12"), as: "search_for_spain_08_12"

    get "/el-clasico-matches" => "search#search_head_to_head", team_one_id: TEAM_FC_BARCELONA_ID, team_two_id: TEAM_REAL_MADRID_ID, term: I18n.t("pages.special_matches.el_clasico"), as: "search_for_el_clasico"

    get "/world-cup-finals" => "competitions#show", id: WORLD_CUP_ID, stages: "Final;Final, replay;Final, 1st leg;Final, 2nd leg", term: I18n.t("pages.special_matches.world_cup_finals"), as: "search_for_world_cup_finals"
    get "/champions-league-finals" => "competitions#show", id: CHAMPIONS_LEAGUE_ID, stages: "Final;Final, replay;Final, 1st leg;Final, 2nd leg", term: I18n.t("pages.special_matches.champions_league_finals"), as: "search_for_champions_league_finals"
    get "/european-cup-finals" => "competitions#show", id: EUROPEAN_CUP_ID, stages: "Final;Final, replay;Final, 1st leg;Final, 2nd leg", term: I18n.t("pages.special_matches.european_cup_finals"), as: "search_for_european_cup_finals"
    get "/copa-libertadores-finals" => "competitions#show", id: COPA_LIBERTADORES_ID, stages: "Final;Final, replay;Final, 1st leg;Final, 2nd leg", term: I18n.t("pages.special_matches.libertadores_finals"), as: "search_libertadores_finals"
  end
end
