class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :matches
  belongs_to :country
  belongs_to :favourite_team, foreign_key: :favourite_team_id, class_name: Team
  
  mount_uploader :avatar, AvatarUploader
  
  ratyrate_rater
  
  extend FriendlyId
  friendly_id :nick_name, use: :slugged

  attr_accessor :favourite_team_name

  def admin?
  	self.role == "admin"
  end

  def name
  	self.nick_name || self.email
  end
end
