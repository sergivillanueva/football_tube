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
  	content_for :title, "Footballia - #{page_title}".truncate(64)
	end
end
