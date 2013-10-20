class Team < ActiveRecord::Base
  def country_name
    ::CountrySelect::COUNTRIES[country_code]
  end
end
