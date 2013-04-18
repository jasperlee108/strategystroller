class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, #end defaults (I removed rememberable, so no cookies. can back later.)
         :confirmable, :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :business_code

  # these validations are redundant - they're ensured through a combination of the database migration/definition and in
  # devise.rb initializer and in the :validatable module. Put here for documentation mainly.
  # validates :email, :presence => true
  # validates :password, :presence => true, :length => { :minimum => 10, :maximum => 128 }

  # TODO add in :username:string, :cu:boolean fields.
  
  ### ASSOCIATIONS (added 03/28/2013)
  has_many :goals
  has_many :indicators
  has_many :owned_projects, :class_name => "Project", :foreign_key => :head_id
  has_many :steering_projects, :class_name => "Project", :foreign_key => :steer_id
  has_many :forms
  
  ### VALIDATIONS (added 04/16/2013)
  # Business code = string[2]
  validates :business_code,
  :presence => true,
  :length => { :maximum => 2 }

  validates_uniqueness_of :email
  
end
