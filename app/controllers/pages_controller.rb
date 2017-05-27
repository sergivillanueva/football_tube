class PagesController < ApplicationController
  
  def home
    #@last_matches_with_video = Video.joins(:match).where(:"matches.published" => true).order("created_at DESC").limit(7).reverse
    @last_matches_with_video = Video.available.joins(:match).select("DISTINCT videos.match_id, matches.*").where(:"matches.published" => true).order("videos.created_at DESC").limit(7).reverse.map(&:match)
    @last_match_with_video = @last_matches_with_video.pop
    @best_matches = Match.joins("LEFT JOIN rating_caches ON (matches.id = rating_caches.cacheable_id) AND (rating_caches.cacheable_type = 'Match')").order("rating_caches.avg DESC, RAND()").limit(15).decorate
    @best_goals = Goal.trimmed.where(super_goal: true).order("RAND()").limit(10)

    @matches_count = Match.count
    @matches_with_videos_count = Match.with_videos.count.length
    @players_count = Player.count
    @goals_count = Goal.count
    @competitions_count = Competition.count
  end

  def about
  end

  def privacy_policy
  end

  def contact
    @contact = Contact.new
  end

  def paypal_donation_ok
    redirect_to home_path, notice: t("donation_successful")
  end

  def paypal_donation_ko
    redirect_to home_path, alert: t("donation_canceled")
  end
end
