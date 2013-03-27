class Goal < ActiveRecord::Base
  attr_accessible :name, :parent, :owner, :need, :justification, :focus, :prerequisite, :notes, :children, :status
  
  ## Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }

  ## Parent = string[30]
  validates :parent,
  :presence => true,
  :length => { :maximum => 30 }

  ## Owner = string[20]
  validates :owner,
  :presence => true,
  :length => { :maximum => 20 }
  
  ## Need = string[1200]
  validates :need,
  :presence => true,
  :length => { :maximum => 1200 }
  
  ## Justification = string[1200]
  validates :justification,
  :presence => true,
  :length => { :maximum => 1200 }
  
  ## Focus = string[1200]
  validates :focus,
  :presence => true,
  :length => { :maximum => 1200 }

  ## Prerequisite = string[2]
  validates :prerequisite,
  :presence => true,
  :length => { :maximum => 2 }
  
  ## Notes = string[600]
  ## Notes can be empty
  validates :notes,
  :length => { :maximum => 600 }

  ## Children = string[6]
  validates :children,
  :presence => true,
  :length => { :maximum => 6 }
  
  ## Status = long integer
  ## 0.00 <= Status <= 100.00
  validates :status,
  :numericality => {
    :greater_than_or_equal_to => 0,
    :less_than_or_equal_to => 100
  }
end
