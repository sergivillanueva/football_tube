class Player < ActiveRecord::Base
  has_many :player_participations
  has_many :matches, through: :player_participations

  
  def as_json(options={})
    { 
      value: self.name,
      label: "#{self.full_name}, #{self.name}"
    }
  end
end
