class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :matches
  belongs_to :country

  mount_uploader :avatar, AvatarUploader
  
  ratyrate_rater
  
  extend FriendlyId
  friendly_id :nick_name, use: :slugged

  def admin?
  	self.role == "admin"
  end

  def name
  	self.nick_name || self.email
  end
end
