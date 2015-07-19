class CountryDecorator < Draper::Decorator
  def flag
    h.content_tag :div, "", style: "display:inline-block;", class: "flag flag-#{object.code}", title: object.name
  end  
end