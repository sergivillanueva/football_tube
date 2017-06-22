module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def title(page_title)
    content_for :title, "#{page_title.truncate(60)} | Footballia"
  end

  def keywords(keywords)
  	content_for :keywords, keywords.truncate(60)
  end

  def description(text)
  	content_for :description, text.truncate(60)
  end

  def jwplayer_needed?
    home_page? ||
    controller.controller_name == "matches" && controller.action_name == "show" ||
    controller.controller_name == "players" &&  controller.action_name == "show" && @goals.any? ||
    controller.controller_name == "teams" &&  controller.action_name == "show" && @goals.any? ||
    controller.controller_name == "competitions" &&  controller.action_name == "show" && @goals.any?
  end

  def home_page?
    controller.controller_name == "pages" && controller.action_name == "home"
  end 

  def datatables_needed?
    controller.action_name == "index" && %w(players competitions teams matches videos rater users).include?(controller.controller_name)
  end

  def google_charts_needed?
    controller.controller_name == "charts"
  end

  def keywords specific_keywords = ""
    generic_keywords = I18n.t("meta_tags.keywords.generic")
    [specific_keywords, generic_keywords].compact.reject(&:empty?).join(", ")
  end

  def open_graph_meta_tags tags
    content_for(:open_graph_meta_tags) do
      [tag("meta", property: "og:type", content: "article"),
      tag("meta", property: "og:title", content: tags[:title]),
      tag("meta", property: "og:description", content: tags[:description]),
      tag("meta", property: "og:image", content: tags[:image])].join("").html_safe
    end
  end

  def meta_tags tags
    content_for(:keywords_meta_tag) do
      tag "meta", name: "keywords", content: keywords(tags[:keywords])
    end

    content_for(:description_meta_tag) do
      [tag("meta", name: "description", content: tags[:description]),
      tag("meta", name: "Description", content: tags[:description]),
      tag("meta", name: "DC.Description", content: tags[:description].truncate(150))].join("").html_safe
    end
  end
end
