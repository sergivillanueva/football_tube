class Team < ActiveRecord::Base
  mount_uploader :emblem, EmblemUploader
  def country_name
    ::CountrySelect::COUNTRIES[country_code]
  end
end
