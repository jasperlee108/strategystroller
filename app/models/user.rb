class User < ActiveRecord::Base
  attr_accessible :company, :name, :password, :position

  validates :name, :presence => true,
                    :length => { :maximum => 128 }
  validates :password, :presence => true,
  					:length => { :maximum => 128 }

end
