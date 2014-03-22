class MatchDecorator < Draper::Decorator
  decorates_association :player_participation
    
  def result
    "#{object.home_score} : #{object.away_score}"
  end
  
  def result_with_logos
    "#{home_team_logo "thumb"} #{result} #{away_team_logo "thumb"}".html_safe
  end
  
  def home_team_logo size = "medium"
    h.image_tag object.home_team.logo.send(size).url, alt: object.home_team.name, title: object.home_team.name
  end
  
  def away_team_logo size = "medium"
    h.image_tag object.away_team.logo.try(size).url, alt: object.away_team.name, title: object.away_team.name
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

  def language
    I18n.t(".language.#{object.language}")
  end  
end