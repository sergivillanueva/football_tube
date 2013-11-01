class Team < ActiveRecord::Base
  mount_uploader :logo, LogoUploader
  def country_name
    ::CountrySelect::COUNTRIES[country_code]
  end
end
