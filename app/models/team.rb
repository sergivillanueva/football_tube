class Team < ActiveRecord::Base
  belongs_to :country
  
  mount_uploader :logo, LogoUploader
  
  def as_json(options={})
    { 
      id: self.id,
      value: self.name,
      name: self.name,
      logo: self.logo.url,
      logo_mini: self.logo.mini.url
    }
  end
end
