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

  def jwplayer_needed?
    controller.controller_name == "pages" && controller.action_name == "home" ||
    controller.controller_name == "matches" && controller.action_name == "show"
  end
end
