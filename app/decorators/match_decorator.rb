class MatchDecorator < ApplicationDecorator
  decorates_association :player_participation
  decorates_association :user
  delegate :current_page, :total_pages, :limit_value
    
  def result
    "#{object.home_score} : #{object.away_score}"
  end
  
  def result_with_logos
    "#{object.home_team.decorate.logo "mini"} #{result} #{object.away_team.decorate.logo "mini"}".html_safe
  end

  def title
    "#{object.home_team.name} vs. #{object.away_team.name}"
  end

  def full_title
    h.content_tag :div, class: "row" do
      h.content_tag(:div, object.home_team.decorate.name, class: "col-xs-4", style: "text-align:right;") +
      h.content_tag(:div, logos.html_safe, class: "col-xs-4", style: "text-align:center;") +
      h.content_tag(:div, object.away_team.decorate.name, class: "col-xs-4")
    end.html_safe
  end

  def full_plain_title
    "#{self.title}, #{self.competition_name}, #{self.playing_date}"
  end

  def logos
    h.content_tag :div, class: "logos" do
      h.content_tag(:span, object.home_team.decorate.logo("small"), style: "text-align:right;") +
      h.content_tag(:span, "-", class: "m-l-xs m-r-xs") +
      h.content_tag(:span, object.away_team.decorate.logo("small"), style: "text-align:left;")
    end
  end

  def title_with_logos size = "thumb", full = false
    "#{object.home_team.decorate.logo size} #{full ? title : 'vs.'} #{object.away_team.decorate.logo size}".html_safe
  end

  def title_with_flags
    "#{object.home_team.country.decorate.flag if object.home_team.country} #{title} #{object.away_team.country.decorate.flag if object.away_team.country}".html_safe
  end
  
  def playing_date
    l object.playing_date, format: :long
  end
    
  def competition_name
    object.competition.name if object.competition.present?
  end
  
  def venue
    object.venue
  end

  def stage
    object.stage
  end

  def season
    object.season
  end

  def language
    I18n.t("languages.#{object.language}") if object.language.present?
  end

  def goals
    object.goals
  end

  def home_players
    object.home_players.map{|player_participation| player_participation.player}
  end

  def away_players
    object.away_players.map{|player_participation| player_participation.player}
  end

  def created_at
    l object.created_at, format: :long
  end

  def videos
    object.videos
  end

  def description
    object.description
  end

  def visualizations_counter
    object.visualizations_counter
  end

  def visits_counter
    object.visits_counter
  end

  def meta_tag_keywords
    [object.home_team.name, object.home_team.nick_names, object.away_team.name, object.away_team.nick_names, competition_name].compact.reject(&:empty?).join(", ")
  end

  def meta_tag_description
    I18n.t("meta_tags.description.match", season: season, title: title, competition: competition_name, stage: stage, venue: venue)
  end

  def published?
    object.published?
  end

  def available?
    object.available?
  end

  def unavailable?
    object.unavailable?
  end

  def recent?
    object.recent?
  end

  def banned?
    object.banned?
  end

  def average_rating
    object.average_rating.round(2)
  end

  def has_seekable_goals?
    object.has_seekable_goals?
  end

  def has_pending_seekable_goals?
    object.has_pending_seekable_goals?
  end

  def sorted_home_starters
    return if object.home_starters.size == 0
    object.home_starters[1..-1].sort_by{|p| p.team_number || 99}.prepend(object.home_starters[0])
  end

  def sorted_away_starters
    return if object.away_starters.size == 0
    object.away_starters[1..-1].sort_by{|p| p.team_number || 99}.prepend(object.away_starters[0])
  end

  def sorted_home_reserves
    object.home_reserves.sort_by{|p| p.team_number || 99}
  end

  def sorted_away_reserves
    object.away_reserves.sort_by{|p| p.team_number || 99}
  end
end
