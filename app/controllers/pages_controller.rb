class PagesController < ApplicationController
  
  def home
    competitions = Competition.completed.group_by(&:scope)

    @national_teams_competitions = competitions["national_teams"].group_by(&:zone) if competitions["national_teams"].present?
    @international_competitions = competitions["international"].group_by(&:zone) if competitions["international"].present?
    @domestic_competitions = competitions["domestic"].group_by(&:zone) if competitions["domestic"].present?
    @friendly = competitions["friendly"] if competitions["friendly"].present?

    @last_match_with_video = Video.last.match
    @best_matches = Match.joins("LEFT JOIN rating_caches ON (matches.id = rating_caches.cacheable_id) AND (rating_caches.cacheable_type = 'Match')").order("rating_caches.avg DESC, #{Rails.env.production? ? 'RAND()' : 'RANDOM()'}").limit(4).decorate

    @matches_count = Match.count
    @matches_with_videos_count = Match.with_videos.count.length
    @players_count = Player.count
    @goals_count = Goal.count
    @competitions_count = Competition.count
  end
      
end