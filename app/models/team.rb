class Team < ActiveRecord::Base
  belongs_to :country
  
  mount_uploader :logo, LogoUploader
  
  def as_json(options={})
    { 
      value: self.name,
      label: self.name,
      logo: self.logo.url
    }
  end
end
