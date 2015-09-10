# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.footballia.net"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add root_path, :changefreq => 'daily', :priority => 0.9

  Match.published.find_each do |match|
    add match_path(match), :lastmod => match.updated_at
  end

  Team.find_each do |team|
    add team_path(team), :lastmod => team.updated_at
  end

  Competition.find_each do |competition|
    add competition_path(competition), :lastmod => competition.updated_at
  end

  Player.find_each do |player|
    add player_path(player), :lastmod => player.updated_at
  end

  add advanced_search_path
  add search_for_clockwork_orange_path
  add search_for_brazil_70_path
  add search_for_dream_team_path
  add search_for_quinta_del_buitre_path
  add search_for_sacchi_milan_path
  add search_for_france_80s_path
  add search_for_spain_08_12_path
  add search_for_el_clasico_path
  add search_for_world_cup_finals_path
  add search_for_champions_league_finals_path
  add search_for_european_cup_finals_path
  add search_libertadores_finals_path

  add about_path
  add contact_path

end
