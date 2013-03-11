class User < ActiveRecord::Base
  #do exception error handling
  #do omniauth

  belongs_to :company
  attr_accessible :company_id, :name, :password, :position
  # position 0 => admin, 1 => CU, 2 => provider
  validates :name, :presence => true,
                    :length => { :maximum => 128 }
  validates_uniqueness_of :name, :scope => :company_id 
  # a company has unique users
  validates :password, :presence => true,
  					:length => { :maximum => 128 }
  validates :company_id, :presence => true
  validates :position, :presence => true

    SUCCESS = 1
    ERR_BAD_CREDENTIALS = -1
    ERR_USER_EXISTS = -2
    ERR_BAD_USERNAME = -3
    ERR_BAD_PASSWORD = -4

    def self.validate_login(name, password, company_id)
        user = User.find_by_name_and_company_id(name, company_id)
        if (!user || user.password != password)
            return ERR_BAD_CREDENTIALS
        else
            return SUCCESS
        end
    end

    def self.get_position(name, password, company_id)
      user = User.find_by_name_and_company_id(name, company_id)
      if (user && user.password == password)
        return user.position
      end
    end

end
