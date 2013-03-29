class Dimension < ActiveRecord::Base
  attr_accessible :name, :status
  has_many :goals
  
  ### ASSOCIATIONS
  ## children
  has_many :goals
  
  ## Name = string[30]
  validates :name,
  :presence => true,
  :length => { :maximum => 30 }
  
  ## Status = long integer
  ## 0.00 <= Status <= 100.00
  validates :status,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
  
end
