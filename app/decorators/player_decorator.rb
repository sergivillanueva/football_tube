class PlayerDecorator < Draper::Decorator
  decorates_association :country
  
  def name
    object.name
  end
  
  def full_name
    object.full_name
  end

  def player_participations_search_link
    h.link_to I18n.t(".search.search"), h.search_by_player_path(player_id: object.id)
  end
end