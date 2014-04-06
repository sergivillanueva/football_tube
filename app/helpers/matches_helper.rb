module MatchesHelper
  def languages_for_select
  	%w(spanish english argentinean mexican other).map do |l|
  	  [I18n.t("languages.#{l}"), l]
  	end
  end
  def options_for_match_season
  	(1950..Date.today.year).map do |year|
  	  [year, "#{year}-#{year + 1}"]
  	end.flatten
  end
end