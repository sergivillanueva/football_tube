class Team < ActiveRecord::Base
  mount_uploader :logo, LogoUploader
  
  def country_name
    ::CountrySelect::COUNTRIES[country_code]
  end
  
  def as_json(options={})
    { 
      value: self.name,
      label: self.name,
      logo: self.logo.url
    }
  end
end
