crumb :root do
  link "Home", root_path
end

crumb :matches do
	link match.title, match_path(match)
	if match.object.competition.present?
	  parent :competition, match.object.competition
	end
end

crumb :competition do |competition|
	link "#{competition.name} matches", competition
end

crumb :advanced_search do
  link t("search.advanced_search.head_to_head"), advanced_search_path
end

crumb :search_by_team do
  link t("search.search_by_team.search_by_team"), advanced_search_path
end

crumb :search_by_player do
  link t("search.search_by_player.search_by_player"), advanced_search_path
end

crumb :search_by_competition do
  link t("search.search_by_competition.search_by_competition"), advanced_search_path
end

crumb :search_by_head_to_head do |title|
  link t("matches_by", name: title), advanced_search_path
  parent :advanced_search
end

crumb :search_player do
  link t("search.player_results.search_player"), advanced_search_path
end

crumb :search_team do
  link t("search.team_results.search_team"), advanced_search_path
end

crumb :about do
  link t("shared.menu.about"), about_path
end

crumb :contact do
  link t("shared.menu.contact"), contact_path
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).
