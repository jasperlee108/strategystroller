class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, #end defaults (I removed rememberable, so no cookies. can back later.)
         :confirmable, :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation #, :remember_me
  # attr_accessible :title, :body

  # these validations are redundant - they're ensured through a combination of the database migration/definition and in
  # devise.rb initializer. Put here for documentation mainly.
  validates :email, :presence => true
  validates :password, :presence => true, :length => { :minimum => 10, :maximum => 128 }


  # TODO add in :username:string, :cu:boolean fields.
end
