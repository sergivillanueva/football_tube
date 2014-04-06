module CompetitionsHelper
  def options_for_competition_kind
  	["league_1", "league_2", "local_cup", "champions_league", "cup_winners_cup", "uefa_cup", "world_cup", "euro", 
  	"african_cup", "international_supercup", "friendly"].map do |l|
  	  [I18n.t("competitions.kind.#{l}"), l]
  	end
  end
end