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
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }
  
  def update_status
    status = 0.00
    self.goals.each do |goal|
      status += goal.status
    end
    self.status = status
  end
  
end
