class PlayerDecorator < Draper::Decorator
  decorates_association :country
  
  def name
    object.name
  end
  
  def full_name
    object.full_name
  end
  
  def player_participations_search_link
    h.link_to h.search_by_player_path(player_id: object.id) do
      h.content_tag(:div, "", class: "fa fa-search lens") +
      h.content_tag(:span, I18n.t(".search.search_matches"), class: "m-l-xs")
    end
  end
end