class Indicator < ActiveRecord::Base
  attr_accessible :actual, :description, :diff, :dir, :freq, :indicator_type, :name, :notes, :source, :status, :status_notes, :target, :unit, :goal_id, :user_id
  
  ### ASSOCIATIONS
  ## parent
  belongs_to :goal
  ## owner
  belongs_to :user
  ## children
  has_many :projects 
  
  # Name = string[80]
  validates :name,
  :presence => true,
  :length => { :maximum => 80 }

  # Needs to have Parent
  validates :goal_id,
  :presence => true

  # Needs to have Owner
  validates :user_id,
  :presence => true
  
  ## Description = string[600]
  ## Description can be empty
  validates :description,
  :length => { :maximum => 600 },
  :allow_blank => true
  
  ## Source = string[200]
  validates :source,
  :presence => true,
  :length => { :maximum => 200 }

  ## Unit = string[20]
  validates :unit,
  :presence => true,
  :length => { :maximum => 20 }

  ## Freq = string[2]
  validates :freq,
  :presence => true,
  :length => { :maximum => 2 }

  ## Type = string[10]
  validates :indicator_type,
  :presence => true,
  :length => { :maximum => 10 }

  ## Dir = string[20]
  validates :dir,
  :presence => true,
  :length => { :maximum => 20 }

  ## Actual = float
  ## 0.00 <= Actual
  validates :actual,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }

  ## Target = float
  ## 0.00 <= Target
  validates :target,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
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

  ## Status Notes = string[600]
  ## Notes can be empty
  validates :status_notes,
  :length => { :maximum => 600 },
  :allow_blank => true

  ## Difference = float
  ## Difference >= 0.0
  validates :diff,
  :presence => true,
  :numericality => { :greater_than_or_equal_to => 0 }
  
end
