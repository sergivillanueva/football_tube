class MatchesController < ApplicationController
  decorates_assigned :match
  before_action :authenticate_user!, except: [:show, :preview_image, :mini_preview_image, :increment_visualizations_counter]
  #TODO use cancancan gem for this and let user crud her own stuff
  before_action :check_admin_role, only: [:destroy, :index, :publish]
  before_action :fetch_match, only: [:update, :edit]

  def new
    @match = Match.new
    @match.videos.build
    build_player_participations
  end
    
  def create
    assign_players_to_match
    assign_coaches_to_match
    
    @match = Match.new match_params.merge({ 
      home_team_id: Team.find_or_create_by({ name: params[:match][:home_team_name] }).id, 
      away_team_id: Team.find_or_create_by({ name: params[:match][:away_team_name] }).id,
      competition_id: Competition.find_or_create_by({ name: params[:match][:competition_name] }).id,
      user_id: current_user.id
    })
    
    if @match.save
      #Redirect to edit to set goals
      redirect_to edit_match_path(@match, set_goals: true)
    else
      render :new
    end
  end
  
  def update
    # Destroy current player_participations since they will be created again to update data
    @match.player_participations.destroy_all

    assign_players_to_match
    assign_coaches_to_match
    
    # Assign teams and competition    
    new_match_params = match_params.merge({ 
      home_team_id: Team.find_or_create_by({ name: params[:match][:home_team_name] }).id, 
      away_team_id: Team.find_or_create_by({ name: params[:match][:away_team_name] }).id,
      competition_id: Competition.find_or_create_by({ name: params[:match][:competition_name] }).id
    })

    if @match.update_attributes new_match_params
      # Check goals since match players may have been changed
      @match.goals.each do |goal|
        goal.destroy unless @match.players.include? goal.player
      end
      if @match.videos.any?
        redirect_to home_path, notice: @match.published? ? t(".match_updated") : t(".match_validation")
      else
        redirect_to home_path, alert: t(".no_videos_found")
      end
    else
      render :edit
    end
  end

  def index
    respond_to do |format|
      format.html
      format.json do
        @matches = Match.includes(:away_team).includes(:home_team).includes(:competition).decorate
        render "matches/index"
      end
    end
  end
  
  def show
    if user_signed_in? && current_user.admin?
      @match = Match.friendly.find(params[:id])
    else
      @match = Match.published.friendly.find(params[:id])
    end
    @related_matches = @match.related_matches
    increment_visits_counter @match
  end

  def edit
    build_player_participations
    (@match.total_score - @match.goals.count).times do 
      @match.goals.build
    end
    @match.videos.build unless @match.videos.any?
    @step = 4 if params[:set_goals].present?
  end

  def destroy
    @match = Match.friendly.find(params[:id])
    @match.destroy
    redirect_to matches_path, notice: "Match deleted"
  end

  def preview_image
    @match = Match.friendly.find(params[:id])
    image = File.open(@match.preview_image, 'rb').read
    response.headers["Expires"] = 1.year.from_now.httpdate
    send_data image, type: 'image/png', disposition: "inline"
  end

  def mini_preview_image
    @match = Match.friendly.find(params[:id])
    image = File.open(@match.mini_preview_image, 'rb').read
    response.headers["Expires"] = 1.year.from_now.httpdate
    send_data image, type: 'image/png', disposition: "inline"
  end

  def increment_visualizations_counter
    @match = Match.friendly.find(params[:id])
    if @match.increment!(:visualizations_counter)
      render json: { status: :ok, code: 1 }
    else
      render json: { status: :error, code: 0 }
    end
  end

  def publish
    @match = Match.friendly.find(params[:id])
    if @match.publish!
      render json: { status: :ok, code: 1 }
    else
      render json: { status: :error, code: 0 }
    end
  end

  private

  def match_params
    params.require(:match).permit(
      :home_score, 
      :away_score, 
      :playing_date, 
      :home_team_name, 
      :away_team_name,
      :home_team_id,
      :away_team_id,
      :competition_name,
      :language,
      :venue,
      :stage,
      :season,
      :description,
      :first_leg_id,
      :second_leg_id,
      :replay_id,
      home_starters_attributes: [:player_name, :side, :player_id, :team_number, :role],
      away_starters_attributes: [:player_name, :side, :player_id, :team_number, :role],
      home_reserves_attributes: [:player_name, :side, :player_id, :team_number, :role],
      away_reserves_attributes: [:player_name, :side, :player_id, :team_number, :role],
      home_coach_attributes: [:player_name, :side, :player_id, :role, :new_player],
      away_coach_attributes: [:player_name, :side, :player_id, :role, :new_player],
      goals_attributes: [:id, :player_id, :minute, :own_goal],
      videos_attributes: [:source_file]
    )
  end
  
  def players_attributes
    [ { key: "home_starters_attributes", side: "home", role: "starter" },
      { key: "home_reserves_attributes", side: "home", role: "reserve" },
      { key: "away_starters_attributes", side: "away", role: "starter" },
      { key: "away_reserves_attributes", side: "away", role: "reserve" } ]
  end
  
  def coaches_attributes
    [ { key: "home_coach_attributes", side: "home", role: "coach" },
      { key: "away_coach_attributes", side: "away", role: "coach" } ]
  end

  def build_player_participations
    (11 - @match.home_starters.count).times do
      @match.home_starters.build({ side: "home", role: "starter" }) #TODO check if params are needed
    end
    (11 - @match.away_starters.count).times do
      @match.away_starters.build({ side: "away", role: "starter" })
    end
    (11 - @match.home_reserves.count).times do
      @match.home_reserves.build({ side: "home", role: "reserve" })
    end
    (11 - @match.away_reserves.count).times do
      @match.away_reserves.build({ side: "away", role: "reserve" })
    end
    @match.build_home_coach unless @match.home_coach.present?
    @match.build_away_coach unless @match.away_coach.present?
  end

  def assign_players_to_match
    # Assign player and secure side and role attributes for players
    players_attributes.each do |attributes|
      params[:match][attributes[:key]] && params[:match][attributes[:key]].each do |player_participation|
        #Find player or create a new one
        player_id = player_participation[1][:player_id]
        player_id = Player.create({ name: player_participation[1][:player_name] }).id unless player_id.present?
        
        player_participation[1].merge!({ player_id: player_id, side: attributes[:side], role: attributes[:role] })
        match_params.merge!(Hash.new(key: player_participation[0], value: player_participation[1]))
      end
    end
  end

  def assign_coaches_to_match
    # Assign player and secure side and role attributes for coaches
    coaches_attributes.each do |attributes|
      player_participation = params[:match][attributes[:key]]

      #Find player or create a new one      
      player_id = player_participation[:player_id]
      player_id = Player.create({ name: player_participation[:player_name] }).id unless player_id.present?
      
      player_participation.merge!({ player_id: player_id, side: attributes[:side], role: attributes[:role] })
      match_params.merge!(Hash.new(key: attributes[:key], value: player_participation))
    end
  end

  def fetch_match
    # User is already signed in, so check only her role
    @match = current_user.admin? ? Match.friendly.find(params[:id]) : current_user.matches.friendly.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to home_path, alert: t("not_authorized")
  end
end
