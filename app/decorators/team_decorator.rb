class TeamDecorator < Draper::Decorator
  decorates_association :country
  
  def name
    object.name
  end
  
  def team_matches_search_link
    h.link_to I18n.t(".search.search"), h.search_by_team_path(team_id: object.id)
  end

  def name_with_flag
    "#{object.country.decorate.flag if object.country} #{name}".html_safe
  end

  def name
    h.content_tag :span, itemscope: "", itemprop: "name" do
    	object.name
    end
  end

  def logo size = nil
    image = size.nil? ? object.logo.url : object.logo.send(size).url
    h.image_tag image, alt: object.name, title: object.name, itemscope: "", itemprop: "logo"
  end
  
end