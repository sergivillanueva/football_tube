class Player < ActiveRecord::Base
  has_many :player_participations
  has_many :matches, through: :player_participations
  has_many :goals
  belongs_to :country
  
  validates :name, presence: true

  scope :uncompleted, -> { where("full_name = '' OR full_name IS NULL OR birthday = '' OR birthday IS NULL") }

  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  def slug_candidates
    [
      :full_name,
      :name,
      [:full_name, :name]
    ]
  end

  def as_json(options={})
    { 
      value: self.name,
      full_name: self.full_name,
      name: self.name,
      country_code: self.country.try(:code),
      birthday: self.birthday,
      id: self.id
    }
  end
  
  def age_at date
    if self.birthday.present?
      age = date.year - self.birthday.year
      age -= 1 if date < birthday + age.years
      age
    end
  end
end
