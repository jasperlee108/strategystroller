class Goal < ActiveRecord::Base
  attr_accessible :focus, :justification, :name, :need, :notes, :status, :dimension_id, :user_id, :prereq
  
  ### ASSOCIATIONS
  ## parent
  belongs_to :dimension
  ## owner
  belongs_to :user
  ## children
  has_many :indicators
  
  ## Needs to have Parent
  validates :dimension_id,
  :presence => true

  ## Needs to have Owner
  validates :user_id,
  :presence => true

  ## Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }
  
  ## Need = string[1200]
  validates :need,
  :length => { :maximum => 1200 },
  :allow_blank => true
  
  ## Justification = string[1200]
  validates :justification,
  :length => { :maximum => 1200 },
  :allow_blank => true
  
  ## Focus = string[1200]
  validates :focus,
  :length => { :maximum => 1200 },
  :allow_blank => true
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Status = long integer
  ## 0.00 <= Status
  validates :status,
  :presence => true,
  :numericality => {
    :greater_than_or_equal_to => 0
  }
  
  ## Prereq = string[80]
  ## Can have zero pre-req if it's the first
  validates :prereq,
  :length => { :maximum => 80 }

  def update_status
    status = 0.00
    self.indicators.each do |indicator|
      status += indicator.contributing_projects_status
    end
    self.status = status
  end

end