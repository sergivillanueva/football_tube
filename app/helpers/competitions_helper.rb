module CompetitionsHelper
  def national_teams_competitions_kinds
  	%w(world_cup world_cup_u20 euro euro_u21 copa_america african_cup international_supercup confederations_cup olympic_games mundialito)
  end
  def international_competitions_kinds
  	%w(champions_league cup_winners_cup uefa_cup international_cup libertadores conmebol mercosur)
  end
  def domestic_competitions_kinds
  	%w(league_1 league_2 cup supercup)
  end
  def grouped_options_for_competition_kind
  	{
  	  t("competitions.scope.national_teams") => national_teams_competitions_kinds.map{|l| [I18n.t("competitions.kind.#{l}"), l]},
  	  t("competitions.scope.international") => international_competitions_kinds.map{|l| [I18n.t("competitions.kind.#{l}"), l]}, 
  	  t("competitions.scope.domestic") => domestic_competitions_kinds.map{|l| [I18n.t("competitions.kind.#{l}"), l]}, 
  	  'friendly' => [[I18n.t("competitions.kind.friendly"), 'friendly']]
  	}
  end
  def options_for_competition_scope
  	%w(national_teams international domestic).map do |s|
  	  [t("competitions.scope.#{s}"), s]
  	end
  end
  def options_for_competition_zone
  	%w(world europe south_america).map do |z|
  	  [t("competitions.zone.#{z}"), z]
  	end  	
  end
end