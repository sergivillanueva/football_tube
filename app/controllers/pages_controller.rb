class PagesController < ApplicationController
  
  def home
    @last_match_with_video = Video.last.try(:match)
    @best_matches = Match.joins("LEFT JOIN rating_caches ON (matches.id = rating_caches.cacheable_id) AND (rating_caches.cacheable_type = 'Match')").order("rating_caches.avg DESC, #{Rails.env.production? ? 'RAND()' : 'RANDOM()'}").limit(15).decorate

    @matches_count = Match.count
    @matches_with_videos_count = Match.with_videos.count.length
    @players_count = Player.count
    @goals_count = Goal.count
    @competitions_count = Competition.count
  end

  def about
  end

  def contact
  end
      
end
