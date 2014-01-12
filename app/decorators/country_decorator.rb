class CountryDecorator < Draper::Decorator
  def flag
    h.content_tag :div, "", style: "inline-block", class: "flag flag-#{object.code}"
  end  
end