class TeamDecorator < Draper::Decorator
  decorates_association :country
  
  def name
    object.name
  end
  
  def team_matches_search_link
    h.link_to I18n.t(".search.search"), h.search_by_team_path(team_id: object.id)
  end
end