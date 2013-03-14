class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :rememberable, and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable, #end defaults (I removed rememberable, so no cookies. can back later.)
         :confirmable, :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :login #, :remember_me
  # attr_accessible :title, :body

  # This is a virtual attribute to allow logging in via username OR email
  attr_accessor :login


  #This code from platformatec wikki: https://github.com/plataformatec/devise/wiki/How-To:-Allow-users-to-sign-in-using-their-username-or-email-address
  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

### This is the correct method you override with the code above
### def self.find_for_database_authentication(warden_conditions)
### end

  # these validations are redundant - they're ensured through a combination of the database migration/definition and in
  # devise.rb initializer and in the :validatable module. Put here for documentation mainly.
  # validates :email, :presence => true
  # validates :password, :presence => true, :length => { :minimum => 10, :maximum => 128 }


  # TODO add in :username:string, :cu:boolean fields.
end
