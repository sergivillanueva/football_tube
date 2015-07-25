class Competition < ActiveRecord::Base
  has_many :matches
  belongs_to :country

  scope :completed, -> { where.not(kind: nil) }
  
  validates :name, presence: true

  extend FriendlyId
  friendly_id :name, use: :slugged
  
  def as_json(options={})
    { 
      value: self.name,
      name: self.name
    }
  end

end
