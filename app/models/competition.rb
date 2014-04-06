class Competition < ActiveRecord::Base
  has_many :matches
  belongs_to :country
  
  validates :name, presence: true  
  
  def as_json(options={})
    { 
      value: self.name,
      name: self.name
    }
  end

end
