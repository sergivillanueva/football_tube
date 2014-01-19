module MatchesHelper
  def languages_for_select
  	%w(spanish english argentinean mexican other).map do |l|
  	  [I18n.t("languages.#{l}"), l]
  	end
  end
end