class MatchDecorator < ApplicationDecorator
  decorates_association :player_participation
  delegate :current_page, :total_pages, :limit_value
    
  def result
    "#{object.home_score} : #{object.away_score}"
  end
  
  def result_with_logos
    "#{home_team_logo "thumb"} #{result} #{away_team_logo "thumb"}".html_safe
  end

  def title
    "#{object.home_team.name} vs. #{object.away_team.name}"
  end

  def full_title
    h.content_tag :div, class: "row" do
      h.content_tag(:div, home_team_name, class: "col-xs-4", style: "text-align:right;") +
      h.content_tag(:div, logos.html_safe, class: "col-xs-4", style: "text-align:center;") +
      h.content_tag(:div, away_team_name, class: "col-xs-4")
    end.html_safe
  end

  def logos
    h.content_tag :div, class: "logos" do
      h.content_tag(:span, home_team_logo("small"), style: "text-align:right;") +
      h.content_tag(:span, "-", class: "m-l-xs m-r-xs") +
      h.content_tag(:span, away_team_logo("small"), style: "text-align:left;")
    end
  end

  def title_with_logos size = "thumb", full = false
    "#{home_team_logo size} #{full ? title : 'vs.'} #{away_team_logo size}".html_safe    
  end

  def title_with_flags
    "#{object.home_team.country.decorate.flag if object.home_team.country} #{title} #{object.away_team.country.decorate.flag if object.away_team.country}".html_safe
  end
  
  def home_team_logo size = nil
    image = size.nil? ? object.home_team.logo.url : object.home_team.logo.send(size).url
    h.image_tag image, alt: object.home_team.name, title: object.home_team.name
  end
  
  def away_team_logo size = nil
    image = size.nil? ? object.away_team.logo.url : object.away_team.logo.send(size).url
    h.image_tag image, alt: object.away_team.name, title: object.away_team.name
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
  
  def home_team_name
    object.home_team.name.mb_chars
  end
  
  def away_team_name
    object.away_team.name.mb_chars
  end

  def home_team_name_with_flag
    "#{object.home_team.country.decorate.flag if object.home_team.country} #{home_team_name}".html_safe
  end

  def away_team_name_with_flag
    "#{object.away_team.country.decorate.flag if object.away_team.country} #{away_team_name}".html_safe
  end

  def created_at
    l object.created_at.to_date, format: :long
  end

  def videos
    object.videos
  end

  def language
    object.language
  end

  def description
    object.description
  end
end