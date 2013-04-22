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
  
  ## Status = decimal
  ## 0.00 <= Status
  validates :status,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }
  
  def update_status   #TODO possibly add call chain to update all values this depends on
    gls = self.goals
    if gls.size == 0
      self.status=0.0
    else
      status = 0.00
      gls.each do |goal|
        status += goal.status
      end
      self.status = status / gls.size
    end
  end
  
end
