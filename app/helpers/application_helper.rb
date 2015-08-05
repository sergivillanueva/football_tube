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
  	content_for :title, "#{page_title.truncate(50)} | Footballia"
	end

  def keywords(keywords)
  	content_for :keywords, keywords.truncate(60)
  end

  def description(text)
  	content_for :description, text.truncate(60)
  end

  def jwplayer_needed?
    controller.controller_name == "pages" && controller.action_name == "home" ||
    controller.controller_name == "matches" && controller.action_name == "show"
  end

  def datatables_needed?
    controller.action_name == "index" && %w(players competitions teams matches).include?(controller.controller_name)
  end

  def keywords specific_keywords = ""
    generic_keywords = case locale.to_s
      when 'en'
        "Champions League games, full length games"
    end
    specific_keywords.present? ? "#{specific_keywords}, #{generic_keywords}" : generic_keywords
  end

  def meta_tags tags
    content_for(:keywords_meta_tag) do
      tag "meta", name: "keywords", content: tags[:keywords]
    end

    content_for(:description_meta_tag) do
      [tag("meta", name: "description", content: tags[:description]),
      tag("meta", name: "Description", content: tags[:description]),
      tag("meta", name: "DC.Description", content: tags[:description].truncate(150))].join("").html_safe
    end
  end
end
