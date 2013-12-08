class Player < ActiveRecord::Base
  has_many :player_participations
  has_many :matches, through: :player_participations
  belongs_to :country
  
  def as_json(options={})
    { 
      value: self.name,
      full_name: self.full_name,
      name: self.name,
      country_code: self.country.try(:code)
    }
  end
end
