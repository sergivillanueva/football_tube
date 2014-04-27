module MatchesHelper
  def languages_for_select
  	%w(no_commentary english russian swedish french spanish german catalan dutch spanish_mex italian spanish_arg portuguese_bra english_usa polish serbian portuguese romanian spanish_col basque galician).map do |l|
  	  [I18n.t("languages.#{l}"), l]
  	end
  end
  def options_for_match_season
  	(1950..Date.today.year).map do |year|
  	  [year, "#{year}-#{year + 1}"]
  	end.flatten
  end
end